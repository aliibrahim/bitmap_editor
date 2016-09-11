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
end
