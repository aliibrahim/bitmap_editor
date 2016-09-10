Dir["#{File.dirname(__FILE__)}/app/bitmap_editor/*.rb"].each { |f| load(f) } #Load all models
require './app/bitmap_editor'

BitmapEditor::Editor.new.run
