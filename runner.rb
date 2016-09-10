Dir["#{File.dirname(__FILE__)}/app/bitmap_editor/*.rb"].each { |f| load(f) } #Load all models for bitmap_editor module

BitmapEditor::Editor.new.run
