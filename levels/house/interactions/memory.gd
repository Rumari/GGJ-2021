extends Node

const scene = preload("res://levels/memory/memory.tscn")

export(String, MULTILINE) var memory_text
export(String, MULTILINE) var hidden_text
export(float) var rot_speed = 5.0
export(float) var duration = 10
export(float) var bullet_freq = 1
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound

func run():
	$AnimationPlayer.play("fade")
	
func _process(delta):
	$Sprite.rotate_y(delta * rot_speed)

func _on_AnimationPlayer_animation_finished(anim_name):
	$ColorRect.modulate.a = 0
	var s = scene.instance()
	s.bullet_freq = bullet_freq
	s.average_bullet_velocity = average_bullet_velocity
	s.velocity_bound = velocity_bound
	s.duration = duration
	s.content = memory_text
	s.hidden_content = hidden_text
	s.destroy_on_win = get_parent().get_path()
	Global.save_old_and_goto_scene(s)
