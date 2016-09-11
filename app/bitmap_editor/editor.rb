module BitmapEditor

  class Editor

    attr_accessor :running, :image

    WELCOME_MESSAGE = 'type ? for help'
    EXIT_MESSAGE    = 'goodbye!'

    def initialize
      @running = true
      @image   = nil
    end

    def run
      puts WELCOME_MESSAGE

      loop do
        print '> '
        run_command(get_command_from_user)
        break if exit?
      end
    end

    def create_image(width, height)
      image = BitmapEditor::Image.new(width: width.to_i, height: height.to_i)
      if image.valid?
        @image = image
        puts 'Image created.'
      else
        puts image.errors.join("\n")
      end
    end

    def clear_image
      begin
        raise NoImageError unless image
        image.clear!
        puts 'Image cleared.'
      rescue NoImageError => e
        puts e
      end
    end

    def color_image_pixel(row, column, color)
      begin
        raise NoImageError unless image
        image.color_pixel(row, column, color)
        puts 'Pixel colored.'
      rescue NoImageError, OutOfBoundError => e
        puts e
      end
    end

    def color_image_vertical(column, start_row, end_row, color)
      begin
        raise NoImageError unless image
        image.color_vertical(column, start_row, end_row, color)
        puts 'Vertical colored.'
      rescue NoImageError, OutOfBoundError => e
        puts e
      end
    end

    def color_image_horizontal(start_column, end_column, row, color)
      begin
        raise NoImageError unless image
        image.color_horizontal(start_column, end_column, row, color)
        puts 'Horizontal colored.'
      rescue NoImageError, OutOfBoundError => e
        puts e
      end
    end

    def display_image
      begin
        raise NoImageError unless image
        image.display
      rescue NoImageError => e
        puts e
      end
    end

    private

    def get_command_from_user
      Kernel.gets.chomp
    end

    def run_command(user_command)
      command = BitmapEditor::Command.new(user_command, self)

      return stop_running if command.exit?
      command.process
    end

    def stop_running
      @running = false
      puts EXIT_MESSAGE
    end

    def exit?
      @running == false
    end
  end

  class NoImageError < StandardError
    def initialize(message= "Please create an image first before trying this operation or press ? for help")
      super(message)
    end
  end

  class OutOfBoundError < StandardError
    def initialize(message= "Given input is out of boundary of the image.")
      super(message)
    end
  end
end
