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
end
