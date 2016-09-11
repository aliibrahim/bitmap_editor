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

    def color_vertical(column, start_row, end_row, color)
      column, start_row, end_row = column.to_i, start_row.to_i, end_row.to_i

      raise OutOfBoundError unless vertical_range_within_boundary?(column, start_row, end_row)
      start_row, end_row = [start_row, end_row].sort # Since the user can draw from bottom to top
      (start_row..end_row).each do |row|
        @grid[row-1][column-1] = color
      end
    end

    def color_horizontal(start_column, end_column, row, color)
      start_column, end_column, row = start_column.to_i, end_column.to_i, row.to_i

      raise OutOfBoundError unless horizontal_range_within_boundary?(start_column, end_column, row)
      start_column, end_column = [start_column, end_column].sort # Since the user can draw from right to left
      (start_column..end_column).each do |column|
        @grid[row-1][column-1] = color
      end
    end

    private

    def initialize_grid
      @grid = Array.new(height) { Array.new(width, 'O') }
    end

    def pixel_within_boundary?(row, column)
      row.between?(MIN_WIDTH, @width) && column.between?(MIN_HEIGHT, @height)
    end

    def vertical_range_within_boundary?(column, start_row, end_row)
      column.between?(MIN_WIDTH, @width) &&
      start_row.between?(MIN_HEIGHT, @height) &&
      end_row.between?(MIN_HEIGHT, @height)
    end

    def horizontal_range_within_boundary?(start_column, end_column, row)
      start_column.between?(MIN_WIDTH, @width) &&
      end_column.between?(MIN_WIDTH, @width) &&
      row.between?(MIN_HEIGHT, @height)
    end
  end
end
