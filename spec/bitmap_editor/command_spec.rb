RSpec.describe BitmapEditor::Command do

  let(:editor){ BitmapEditor::Editor.new  }
  subject     { BitmapEditor::Command.new }

  describe '#process' do
    before do
      allow(subject).to receive(:editor) { editor }
    end

    context 'command ?' do
      before do
        allow(subject).to receive(:command) { '?' }
      end

      it 'prints HELP text to screen' do
        expect { subject.process }.to output(BitmapEditor::Command::HELP_TEXT).to_stdout
      end
    end

    context 'command I' do

      context 'with valid arguments' do
        let(:args) { ['10', '20']}

        before do
          allow(subject).to receive(:command) { 'I 10 20' }
        end

        it 'allows editor to create image' do
          expect(subject.editor).to receive(:create_image).with(*args)

          subject.process
        end
      end

      context 'with invalid arguments' do
        before do
          allow(subject).to receive(:command) { 'I 10' }
        end

        it 'prints exception message to screen' do
          expect { subject.process }.to output("The supplied arguments are not valid for this command. Try again or press ? for help\n").to_stdout
        end
      end
    end

    context 'unknown command' do
      before do
        allow(subject).to receive(:command) { 'abc' }
      end

      it 'prints message that command is unknown' do
        expect { subject.process }.to output(BitmapEditor::Command::UNKNOWN_COMMAND + "\n").to_stdout
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
