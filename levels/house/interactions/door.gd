extends StaticBody

const Scene = preload("res://levels/bedroom/bedroom.tscn")
const Text = preload("res://levels/text.tscn")

var text

func run():
	text = Text.instance()
	if Global.level == 4:
		text.content = [
			"[You use the key you found to unlock the door]",
			"[...]",
			"[The door opens slowly]"
		]
	else:
		text.content = [
			"[The door to your bedroom is locked]",
			"[You don't remember where you hid the key]",
		]
	add_child(text)
	text.connect("closed", self, "_on_Text_closed")

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.goto_scene(Scene.instance())

func _on_Text_closed():
	if Global.level == 4:
		$AnimationPlayer.play("fade")
