extends StaticBody

const scene = preload("res://levels/bedroom/bedroom.tscn")

func run():
	if Global.level == 4:
		$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	var s = scene.instance()
	Global.goto_scene(s)
