extends StaticBody

#const scene = preload("res://levels/memory/memory.tscn")

func run():
	if Global.level == 4:
		print_debug("Enter room")
	else:
		print_debug("Cant enter room")
	#$AnimationPlayer.play("fade")

#func _on_AnimationPlayer_animation_finished(anim_name):
#	$ColorRect.modulate.a = 0
#	var s = scene.instance()
#	s.paragraph = memory_text
#	s.destroy_on_win = get_parent().get_path()
#	Global.save_old_and_goto_scene(s)
