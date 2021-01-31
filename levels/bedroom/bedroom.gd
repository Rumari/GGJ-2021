extends Spatial

const Memory = preload("res://levels/memory/memory.tscn")
const Ending = preload("res://levels/ending/ending.tscn")

export(String, MULTILINE) var memory_content
export(float) var bullet_freq = 1
export(float) var duration = 120.0
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound

var start_fight = 0
var memory = null

func _ready():
	$TransitionAnimation.play_backwards("fade")
	
func _process(delta):
	if memory != null:
		memory.bullet_freq = bullet_freq
		memory.average_bullet_velocity = average_bullet_velocity
		memory.velocity_bound = velocity_bound

func _on_TriggerArea_body_entered(body):
	start_fight = 1
	$TransitionAnimation.play("fade")
	print_debug("Fight start")

func _on_AnimationPlayer_animation_finished(anim_name):
	if start_fight == 1:
		# Move to position
		$Fight/Camera.current = true
		$Player.translation.x = $Fight.translation.x
		$Player.translation.z = $Fight.translation.z
		$Player.rotation_degrees.y = -90.0
		$Player.visible = false
		$Player.set_process(false)
		$Player.set_physics_process(false)
		$Player.set_process_input(false)
		$TransitionAnimation.play_backwards("fade")
		start_fight = 2
	elif start_fight == 2:
		memory = Memory.instance()
		memory.content = memory_content
		memory.final = true
		memory.duration = duration
		memory.connect("win", self, "_on_Memory_win")
		memory.connect("game_over", self, "_on_Memory_game_over")
		$Transition/ColorRect.modulate = Color(0, 0, 0, 0.2)
		$Fight.add_child(memory)
		$FightAnimation.play("fight")
		
func _on_Memory_win():
	Global.level += 1
	var scene = Ending.instance()
	Global.goto_scene(scene)

func _on_Memory_game_over():
	get_tree().reload_current_scene()
