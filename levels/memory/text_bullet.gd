extends Node2D

export var text = ""
var progress = 0
var original_text

export(Vector3) var velocity;

func _ready():
	$Text/Begin.text = ""
	$Text/End.text = text
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if 65 <= event.scancode and event.scancode <= 90: # A to Z
			enter_character(char(event.scancode))

func enter_character(chr):
	if text[progress].to_upper() != chr:
		return
	
	progress += 1
	if progress == len(text):
		get_parent().remove_child(self)
	else:
		$Text/Begin.text = text.substr(0, progress)
		$Text/End.text = text.substr(progress)
		
