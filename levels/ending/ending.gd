extends Control

func _ready():
	$Control.hide()
	$Control/Credits.set_process(false)	

func _on_Text_closed():
	$Control.show()
	$Control/Credits.set_process(true)

func _on_Credits_end():
	$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.level = 5
	Global.goto_scene_from_path("res://levels/titlescreen/titlescreen.tscn")
