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
