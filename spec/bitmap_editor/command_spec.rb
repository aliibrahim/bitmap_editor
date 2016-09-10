RSpec.describe BitmapEditor::Command do

  subject { BitmapEditor::Command.new}

  describe '#process' do
    before do
      allow(subject).to receive(:command) { '?' }
    end

    context 'command ?' do
      it 'prints HELP text to screen' do
        expect { subject.process }.to output(BitmapEditor::Command::HELP_TEXT).to_stdout
      end
    end

    context 'unknown command' do
      before do
        allow(subject).to receive(:command) { 'abc' }
      end

      it 'prints message that command is unknown' do
        expect { subject.process }.to output(BitmapEditor::Command::UNKNOWN_COMMAND_MESSAGE + "\n").to_stdout
      end
    end

  end

  describe '#exit?' do

    context 'command X' do
      before do
        allow(subject).to receive(:command) { 'X' }
      end

      it 'returns true' do
        expect(subject.exit?).to be_truthy
      end
    end

    context 'command abc' do
      before do
        allow(subject).to receive(:command) { 'abc' }
      end

      it 'returns true' do
        expect(subject.exit?).to be_falsy
      end
    end
  end

end
