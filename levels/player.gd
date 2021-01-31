extends KinematicBody

const Footsteps = preload("res://fx/footsteps.wav")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var movement_speed = 4.0
export(float) var look_sensitivity = 100.0
export(float) var animation_multiplier = 1.15

var vertical_vel = 0.0
var time = 0.0
var frame = 0

func _physics_process(delta):
	if Global.on_text:
		return
			
	var movement = 0.0
	if Input.is_action_pressed("forward"):
		movement -= 1.0
	if Input.is_action_pressed("behind"):
		movement += 1.0
		
	var angle = 0.0
	if Input.is_action_pressed("left"):
		angle += 1.0
	if Input.is_action_pressed("right"):
		angle -= 1.0
		
	var vel = movement * movement_speed * transform.basis.z
	vel.y += vertical_vel
	vertical_vel -= 9.8 * delta
	
	if is_on_floor():
		vertical_vel = 0.0
		
	if movement != 0.0:
		time += delta
		frame = int(time * movement_speed * animation_multiplier) % 4
		$Sprite.frame = frame
		if is_on_floor():
			var player = get_parent().get_node("AudioStreamPlayer")
			if not player.is_playing():
				player.set_stream(Footsteps)
				player.play()
	else:
		var player = get_parent().get_node("AudioStreamPlayer")
		player.stop()
		time = 0.0
		frame = 0
		$Sprite.frame = frame
	
	rotation_degrees.y += angle * look_sensitivity * delta
	move_and_slide(vel, Vector3.UP)
