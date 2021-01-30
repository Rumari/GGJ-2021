extends Area

export(float) var rot_speed
export(NodePath) var interaction

func _process(delta):
    $Sprite.rotate_y(delta * rot_speed)

func _input(event):
    if event.is_action_pressed("confirm") && len(get_overlapping_bodies()) > 0:
        get_node(interaction).run()
