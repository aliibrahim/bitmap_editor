module BitmapEditor
  class Image

    attr_accessor :width, :height, :grid, :errors

    MIN_WIDTH  = 1
    MIN_HEIGHT = 1
    MAX_WIDTH  = 255
    MAX_HEIGHT = 255

    INVALID_WIDTH_MESSAGE  = "Invalid width given. Please ensure width is between #{MIN_WIDTH} and #{MAX_WIDTH}"
    INVALID_HEIGHT_MESSAGE = "Invalid height given. Please ensure height is between #{MIN_HEIGHT} and #{MAX_HEIGHT}"

    def initialize(width:, height:, grid: nil)
      @width, @height =  width, height
      initialize_grid
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

    def clear!
      initialize_grid
    end

    def color_pixel(row, column, color)
      row, column = row.to_i, column.to_i

      raise OutOfBoundError unless pixel_within_boundary?(row, column)
      @grid[row-1][column-1] = color
    end

    private

    def initialize_grid
      @grid = Array.new(height) { Array.new(width, 'O') }
    end

    def pixel_within_boundary?(row, column)
      row.between?(MIN_WIDTH, @width) && column.between?(MIN_HEIGHT, @height)
    end

  end
end