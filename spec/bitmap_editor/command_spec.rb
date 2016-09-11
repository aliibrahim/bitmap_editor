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
          expect { subject.process }.to output(BitmapEditor::InvalidArguments.new.message+ "\n").to_stdout
        end
      end
    end

    context 'command C' do
      before do
        allow(subject).to receive(:command) { 'C' }
      end
      it 'allows editor to call clear_image' do
        expect(subject.editor).to receive(:clear_image)

        subject.process
      end
    end

    context 'command L' do

      context 'with valid arguments' do
        let(:args) { ['10', '20', 'C']}

        before do
          allow(subject).to receive(:command) { 'L 10 20 C' }
        end

        it 'allows editor to color pixel image' do
          expect(subject.editor).to receive(:color_image_pixel).with(*args)

          subject.process
        end
      end

      context 'with invalid arguments' do
        before do
          allow(subject).to receive(:command) { 'L 10' }
        end

        it 'prints exception message to screen' do
          expect(subject.editor).to_not receive(:color_image_pixel)
          expect { subject.process }.to output(BitmapEditor::InvalidArguments.new.message+ "\n").to_stdout
        end
      end
    end

    context 'command V' do

      context 'with valid arguments' do
        let(:args) { ['200', '10', '20', 'C']}

        before do
          allow(subject).to receive(:command) { 'V 200 10 20 C' }
        end

        it 'allows editor to color pixel image' do
          expect(subject.editor).to receive(:color_image_vertical).with(*args)

          subject.process
        end
      end

      context 'with invalid arguments' do
        before do
          allow(subject).to receive(:command) { 'V 10 Helloworld' }
        end

        it 'prints exception message to screen' do
          expect(subject.editor).to_not receive(:color_image_vertical)
          expect { subject.process }.to output(BitmapEditor::InvalidArguments.new.message+ "\n").to_stdout
        end
      end
    end

    context 'command V' do

      context 'with valid arguments' do
        let(:args) { ['2', '10', '20', 'C']}

        before do
          allow(subject).to receive(:command) { 'H 2 10 20 C' }
        end

        it 'allows editor to color pixel image' do
          expect(subject.editor).to receive(:color_image_horizontal).with(*args)

          subject.process
        end
      end

      context 'with invalid arguments' do
        before do
          allow(subject).to receive(:command) { 'H 10 Helloworld' }
        end

        it 'prints exception message to screen' do
          expect(subject.editor).to_not receive(:color_image_horizontal)
          expect { subject.process }.to output(BitmapEditor::InvalidArguments.new.message+ "\n").to_stdout
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
