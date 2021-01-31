extends Node2D

export var text = ""
var progress = 0
var original_text
var selected = false
var offset
var valid = true

signal hit

export(Vector2) var velocity
export(Color) var selected_color

func _ready():
	$Text/Begin.text = ""
	$Text/End.text = text
	
func _physics_process(delta):
	position += velocity * delta

func select():
	selected = true
	$Text/Begin.add_color_override("font_color", selected_color) 
	$Text/End.add_color_override("font_color", selected_color) 

func enter_character(chr):
	if !valid or text[progress].to_upper() != chr:
		return 0
	
	progress += 1
	if progress == len(text):
		valid = false
		queue_free()
		return 2
	else:
		$Text/Begin.text = text.substr(0, progress)
		$Text/End.text = text.substr(progress)
		return 1
		
func _on_area_entered(area):
	area.damage()
	emit_signal("hit")
	queue_free()
