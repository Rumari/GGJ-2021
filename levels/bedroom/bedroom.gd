extends Spatial

const Memory = preload("res://levels/memory/memory.tscn")

export(String, MULTILINE) var memory_content

var start_fight = 0

func _ready():
	$AnimationPlayer.play_backwards("fade")

func _on_TriggerArea_body_entered(body):
	start_fight = 1
	$AnimationPlayer.play("fade")
	print_debug("Fight start")

func _on_AnimationPlayer_animation_finished(anim_name):
	if start_fight == 1:
		# Move to position
		$Fight/Camera.current = true
		$Player.translation.x = $Fight.translation.x
		$Player.translation.z = $Fight.translation.z
		$Player.visible = false
		$Player.set_process(false)
		$Player.set_physics_process(false)
		$Player.set_process_input(false)
		$AnimationPlayer.play_backwards("fade")
		start_fight = 2
	elif start_fight == 2:
		var memory = Memory.instance()
		memory.content = memory_content
		memory.final = true
		$Fight.add_child(memory)
