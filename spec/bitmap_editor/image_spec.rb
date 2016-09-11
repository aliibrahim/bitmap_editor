RSpec.describe BitmapEditor::Image do

  subject { BitmapEditor::Image.new(width: 2, height: 3) }

  describe '#initialize' do

    context 'with valid width and height' do

      let(:grid) {[['O','O'],['O','O'],['O','O']]}

      it 'correctly sets width and height' do
        expect(subject.width).to eq 2
        expect(subject.height).to eq 3
        expect(subject.grid).to eq grid
      end
    end
  end

  describe '#clear!' do

    context 'with filled image' do
      let(:empty_grid) {[['O','O'],['O','O'],['O','O']]}

      before do
        subject.grid = [['A','A'],['B','B'],['C','C']]
      end

      it 'clears the image' do
        subject.clear!

        expect(subject.width).to eq 2
        expect(subject.height).to eq 3
        expect(subject.grid).to eq empty_grid
      end
    end
  end

  describe '#color_pixel' do
    context 'within valid dimensions' do

      let(:expected_grid) {[['O','C'],['O','O'],['O','O']]}

      before do
        subject.grid = [['O','0'],['O','O'],['O','O']]
      end

      it 'colors the given pixel' do
        subject.color_pixel(1,2,'C')

        expect(subject.grid).to eq expected_grid
      end
    end

    context 'with invalid dimensions' do
      it 'raises OutOfBoundError exception' do
        expect { subject.color_pixel(10,2,'C') }.to raise_error(BitmapEditor::OutOfBoundError)
      end
    end
  end

  describe '#color_vertical' do
    context 'within valid dimensions' do

      let(:expected_grid) {[['O','C'],['O','C'],['O','C']]}

      before do
        subject.grid = [['O','O'],['O','O'],['O','O']]
      end

      it 'vertically colors the image' do
        subject.color_vertical(2, 1, 3, 'C')

        expect(subject.grid).to eq expected_grid
      end

      it 'vertically colors the image from bottom to top' do
        subject.color_vertical(2, 3, 1, 'C')

        expect(subject.grid).to eq expected_grid
      end
    end

    context 'with invalid dimensions' do
      it 'raises OutOfBoundError exception' do
        expect { subject.color_vertical(3, 1, 3, 'C') }.to raise_error(BitmapEditor::OutOfBoundError)
      end
    end
  end
end
