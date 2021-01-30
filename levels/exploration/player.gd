extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var movement_speed = 4.0
export(float) var look_sensitivity = 100.0
export(float) var animation_multiplier = 1.15

var vertical_vel = 0.0
var time = 0.0
var DaBaby = load("res://dcc/dababy.png") 
var DaBabyVector = 0


func _enter_tree():
	if Global.DaBaby:
		$Sprite.set_texture(DaBaby)
		DaBabyVector = Vector3(.05, .05, .05)
		$Sprite.set_scale(DaBabyVector)
		$Sprite.set_hframes(1)

func _physics_process(delta):
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
		$Sprite.frame = int(time * movement_speed * animation_multiplier) % 4
	else:
		time = 0.0
		$Sprite.frame = 0
	
	rotation_degrees.y += angle * look_sensitivity * delta
	move_and_slide(vel, Vector3.UP)
