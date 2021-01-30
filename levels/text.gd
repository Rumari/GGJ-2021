extends Panel

export(Array, String) var content = []
export(int, 1, 20) var line_delay = 10
export(int, 1, 20) var character_delay = 1

signal closed

var line = 0
var column = 0
var ticks = 0
var start = false
var finished = false

func append_text(txt):
	$MarginContainer/Label.append_bbcode(txt)

func _ready():
	$AnimationPlayer.play("fade")
	$MarginContainer/Label.bbcode_text = ""

func _input(event):
	if event.is_action_pressed("confirm"):
		if finished:
			$Confirm.visible = false
			$AnimationPlayer.play_backwards("fade")
		else:
			if len(content[line]) != column:
				append_text(content[line].substr(column))
				column = len(content[line])
			ticks = line_delay	

func _on_Timer_timeout():
	if finished or line == len(content):
		finished = true
		$Confirm.visible = true
		return
	elif !start:
		return
	
	ticks = ticks + 1
	if len(content[line]) == column:
		if ticks >= line_delay:
			ticks = 0
			append_text("\n")
			line = line + 1
			column = 0
	else:
		if ticks >= character_delay:
			ticks = 0
			append_text(content[line][column])
			column = column + 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if finished:
		emit_signal("closed")
		queue_free()
	else:
		start = true
