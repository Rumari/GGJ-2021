extends Control

func _on_Credits_end():
	$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.level = 5
	Global.goto_scene_from_path("res://levels/titlescreen/titlescreen.tscn")
