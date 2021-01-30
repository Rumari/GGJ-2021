extends Node

const scene = preload("res://levels/memory/memory.tscn")

export(String, MULTILINE) var memory_text
export(String, MULTILINE) var hidden_text
export(float) var rot_speed = 5.0

func run():
	$AnimationPlayer.play("fade")
	
func _process(delta):
	$Sprite.rotate_y(delta * rot_speed)

func _on_AnimationPlayer_animation_finished(anim_name):
	$ColorRect.modulate.a = 0
	var s = scene.instance()
	s.content = memory_text
	s.hidden_content = hidden_text
	s.destroy_on_win = get_parent().get_path()
	Global.save_old_and_goto_scene(s)
