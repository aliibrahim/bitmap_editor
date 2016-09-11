module BitmapEditor
  class Image

    attr_accessor :width, :height, :grid, :errors

    MIN_WIDTH  = 1
    MIN_HEIGHT = 1
    MAX_WIDTH  = 255
    MAX_HEIGHT = 255

    INVALID_WIDTH_MESSAGE  = "Invalid width given. Please ensure width is between #{MIN_WIDTH} and #{MAX_WIDTH}"
    INVALID_HEIGHT_MESSAGE = "Invalid height given. Please ensure height is between #{MIN_HEIGHT} and #{MAX_HEIGHT}"

    def initialize(width:, height:)
      @width, @height =  width, height
      @grid = initialize_grid
    end

    def valid?
      @errors = []
      return true if @width.between?(MIN_WIDTH, MAX_WIDTH) && @height.between?(MIN_HEIGHT, MAX_HEIGHT)

      unless @width.between?(MIN_WIDTH, MAX_WIDTH)
        @errors << INVALID_HEIGHT_MESSAGE
      end
      unless @height.between?(MIN_HEIGHT, MAX_HEIGHT)
        @errors << INVALID_HEIGHT_MESSAGE
      end

      false
    end

    private

    def initialize_grid
      Array.new(height) { Array.new(width, 'O') }
    end
  end
end
