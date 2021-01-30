extends Camera

onready var dir = translation.normalized()
onready var max_distance = translation.length()
onready var height = translation.y

func _physics_process(delta):
	var space_state = get_world().direct_space_state
	var hit = space_state.intersect_ray(
		get_parent().to_global(Vector3.ZERO),
		get_parent().to_global(dir * max_distance)
	)
	
	var distance = max_distance
	if hit:
		distance = (hit.position - get_parent().global_transform.origin).length()
	translation = dir * distance
	translation.y = height
