extends Area

export(float) var rot_speed
export(NodePath) var interaction

func _enter_tree():
	get_parent().get_node("Confirm").hide()
	
func _process(delta):
	$Sprite.rotate_y(delta * rot_speed)
	show()

func _input(event):
	if event.is_action_pressed("confirm") && len(get_overlapping_bodies()) > 0:
		get_node(interaction).run()

func show():
	if len(get_overlapping_bodies()) > 0:
		get_parent().get_node("Confirm").show()
	else:
		get_parent().get_node("Confirm").hide()
