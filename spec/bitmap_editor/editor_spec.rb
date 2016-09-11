RSpec.describe BitmapEditor::Editor do

  subject { BitmapEditor::Editor.new}

  PROMPT= '>'

  describe '#run' do
    before do
      allow(subject).to receive(:loop).and_yield
      allow(subject).to receive(:run_command).and_call_original
    end

    context 'on user command X' do
      before do
        allow(subject).to receive(:get_command_from_user) { 'X' }
      end

      it 'finishes the program' do
        expect(subject).to receive(:run_command).once
        expect { subject.run }.to output(exit_message).to_stdout
      end
    end

    context 'command ?' do
      before do
        allow(subject).to receive(:get_command_from_user) { '?' }
      end

      it 'prints HELP to screen' do
        expect { subject.run }.to output(help_message).to_stdout
      end
    end
  end

  describe '#create_image' do

    before do
      allow(BitmapEditor::Image).to receive(:new).and_call_original
    end

    context 'with valid dimensions' do

      let(:width)  { 100 }
      let(:height) { 200 }

      it 'creates the image' do
        expect { subject.create_image(width, height) }.to output("Image created.\n").to_stdout
      end
    end

    context 'with invalid dimensions' do

      let(:width)  { 10 }
      let(:height) { 2000 }

      it 'prints error image' do
        expect { subject.create_image(width, height) }.to output(BitmapEditor::Image::INVALID_HEIGHT_MESSAGE+"\n").to_stdout
      end
    end
  end

  describe '#clear_image' do
    context 'when image is not present' do

      it 'prints NoImageError error message' do
        expect { subject.clear_image }.to output(BitmapEditor::NoImageError.new.message+"\n").to_stdout
      end
    end

    context 'when image is present' do
      before do
        image = BitmapEditor::Image.new(width: 10, height: 10)
        allow(subject).to receive(:image).and_return image
      end

      it 'prints Image cleared. message' do
        expect { subject.clear_image }.to output("Image cleared.\n").to_stdout
      end
    end
  end

  describe '#color_image_pixel' do

    let(:row)   { 5 }
    let(:column){ 5 }
    let(:color) {'C'}

    context 'when image is not present' do
      it 'prints NoImageError error message' do
        expect { subject.color_image_pixel(row, column, color) }.to output(BitmapEditor::NoImageError.new.message+"\n").to_stdout
      end
    end

    context 'when image is present' do
      context 'when pixel is within dimensions' do
        before do
          image = BitmapEditor::Image.new(width: 10, height: 10)
          allow(subject).to receive(:image).and_return image
        end

        it 'prints Pixel colored message' do
          expect { subject.color_image_pixel(row, column, color) }.to output("Pixel colored.\n").to_stdout
        end
      end

      context 'when pixel is outside of dimensions' do
        before do
          image = BitmapEditor::Image.new(width: 2, height: 2)
          allow(subject).to receive(:image).and_return image
        end

        it 'prints OutOfBoundError message' do
          expect { subject.color_image_pixel(row, column, color) }.to output(BitmapEditor::OutOfBoundError.new.message+"\n").to_stdout
        end
      end
    end
  end

  describe '#color_image_vertical' do

    let(:column)    { 2 }
    let(:start_row) { 2 }
    let(:end_row)   { 4 }
    let(:color) {'C'}

    context 'when image is not present' do
      it 'prints NoImageError error message' do
        expect { subject.color_image_vertical(column, start_row, end_row, color) }.to output(BitmapEditor::NoImageError.new.message+"\n").to_stdout
      end
    end

    context 'when image is present' do
      context 'when pixel is within dimensions' do
        before do
          image = BitmapEditor::Image.new(width: 2, height: 4)
          allow(subject).to receive(:image).and_return image
        end

        it 'prints Pixel colored message' do
          expect { subject.color_image_vertical(column, start_row, end_row, color) }.to output("Vertical colored.\n").to_stdout
        end
      end

      context 'when pixel is outside of dimensions' do
        before do
          image = BitmapEditor::Image.new(width: 2, height: 2)
          allow(subject).to receive(:image).and_return image
        end

        it 'prints OutOfBoundError message' do
          expect { subject.color_image_vertical(column, start_row, end_row, color) }.to output(BitmapEditor::OutOfBoundError.new.message+"\n").to_stdout
        end
      end
    end
  end

  describe '#color_image_horizontal' do

    let(:start_column) { 1 }
    let(:end_column)   { 3 }
    let(:row)   { 4 }
    let(:color) {'C'}

    context 'when image is not present' do
      it 'prints NoImageError error message' do
        expect { subject.color_image_horizontal(start_column, end_column, row, color) }.to output(BitmapEditor::NoImageError.new.message+"\n").to_stdout
      end
    end

    context 'when image is present' do
      context 'when pixel is within dimensions' do
        before do
          image = BitmapEditor::Image.new(width: 3, height: 4)
          allow(subject).to receive(:image).and_return image
        end

        it 'prints Pixel colored message' do
          expect { subject.color_image_horizontal(start_column, end_column, row, color) }.to output("Horizontal colored.\n").to_stdout
        end
      end

      context 'when pixel is outside of dimensions' do
        before do
          image = BitmapEditor::Image.new(width: 2, height: 2)
          allow(subject).to receive(:image).and_return image
        end

        it 'prints OutOfBoundError message' do
          expect { subject.color_image_horizontal(start_column, end_column, row, color) }.to output(BitmapEditor::OutOfBoundError.new.message+"\n").to_stdout
        end
      end
    end
  end

  describe '#display_image' do
    context 'when image is not present' do

      it 'prints NoImageError error message' do
        expect { subject.display_image }.to output(BitmapEditor::NoImageError.new.message+"\n").to_stdout
      end
    end

    context 'when image is present' do
      let(:expected_output) do <<~IMAGE
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
       O O O O O O O O O O
IMAGE
      end

      before do
        image = BitmapEditor::Image.new(width: 10, height: 10)
        allow(subject).to receive(:image).and_return image
      end

      it 'prints image' do
        expect { subject.display_image }.to output(expected_output).to_stdout
      end
    end
  end

  private
    def exit_message
      welcome_message(BitmapEditor::Editor::EXIT_MESSAGE + "\n")
    end

    def help_message
      welcome_message(BitmapEditor::Command::HELP_TEXT)
    end

    def welcome_message(str)
      BitmapEditor::Editor::WELCOME_MESSAGE + "\n" + PROMPT + ' ' + str
    end
end
