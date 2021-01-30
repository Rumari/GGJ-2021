extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level = Global.level
var song = 0

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	match level:
		0:
			song = load("res://music/song1.ogg")
		1:
			song = load("res://music/song2.ogg")
		2:
			song = load("res://music/song3.ogg")
		3:
			song = load("res://music/song4.ogg")
	self.set_stream(song)
	self.play()

func _process(delta):
	if Global.level != level:
		level = Global.level
		_enter_tree()
