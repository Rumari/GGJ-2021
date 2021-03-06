extends Spatial

const Text = preload("res://levels/text.tscn")

var timer
var text

func _enter_tree():
	if Global.level == 4:
		timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(1)
		timer.connect("timeout", self, "_on_Timer_timeout")
		add_child(timer)
		timer.start()
	$AnimationPlayer.play("fade")
	$CRT/CRT.modulate = Color(1, 1, 1, (4 - Global.level) * 0.2)
	$WorldEnvironment.environment.ambient_light_energy = 0.01 + Global.level * 0.005
	$WorldEnvironment.environment.adjustment_saturation = 0.6 + Global.level * 0.1
	
func _on_Timer_timeout():
	text = Text.instance()
	text.content = [
		"[You remember where the key to your bedroom was]",
		"[...]",
		"[...]",
		"[...]",
		"[You find the key]"
	]
	add_child(text)
	text.connect("closed", self, "_on_Text_closed")
	timer.queue_free()
	
func _on_Text_closed():
	text.queue_free()
