module BitmapEditor

  class Command

    attr_accessor :command, :editor

    HELP_TEXT=<<~HELP
? - Help
I M N - Create a new M x N image with all pixels coloured white (O). Both M and N should be between 1 and 255.
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session
HELP

    UNKNOWN_COMMAND = 'unrecognised command :( Try again or press ? for help'

    def initialize(command= nil, editor= nil)
      @command = command
      @editor  = editor
    end

    def process
      command, *args = parse_command
      begin
        case command
          when '?'
            puts HELP_TEXT
          when 'I'
            raise InvalidArguments if args.length != 2
            editor.create_image(*args)
          else
            puts UNKNOWN_COMMAND
        end
      rescue InvalidArguments => e
        puts e
      end
    end

    def exit?
      command == 'X'
    end

    private
    def parse_command
      command.split(' ')
    end
  end

  class InvalidArguments < StandardError
    def initialize(message= "The supplied arguments are not valid for this command. Try again or press ? for help")
      super(message)
    end
  end
end
