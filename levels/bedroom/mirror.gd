extends Spatial

export(NodePath) var target_path
export(bool) var animate = false

onready var target = get_node(target_path)

func _physics_process(delta):
	translation = target.global_transform.origin
	translation.x *= -1
	rotation = target.rotation
	rotation_degrees.y *= -1
	
	if animate:
		for node in get_children():
			if node is Sprite3D:
				node.frame = target.frame
	#rotation = target.global_transform.rotation
