module BitmapEditor

  class Editor

    attr_accessor :running

    WELCOME_MESSAGE = 'type ? for help'
    EXIT_MESSAGE   = 'goodbye!'

    def initialize
      @running = true
    end

    def run
      puts WELCOME_MESSAGE

      loop do
        print '> '
        run_command(get_command_from_user)
        break if exit?
      end
    end

    private

    def get_command_from_user
      Kernel.gets.chomp
    end

    def run_command(user_command)
      command = BitmapEditor::Command.new(user_command)

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
