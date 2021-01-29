extends Node2D


export var text = ""
var progress = 0
var original_text

func _ready():
	original_text  = $Text.bbcode_text
	$Text.bbcode_text = original_text.replace("{text}", text);

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
		$Text.bbcode_text = original_text.replace(
			"{text}",
			"[size=14]%s[/size][size=10]%s[/size]" % [text.substr(0, progress), text.substr(progress)]
		);
