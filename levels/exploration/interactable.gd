extends Area

export(NodePath) var interaction

func _enter_tree():
	get_parent().get_node("Confirm").hide()

func _input(event):
	if event.is_action_pressed("confirm") && len(get_overlapping_bodies()) > 0:
		get_node(interaction).run()

func _on_Interactable_body_entered(body):
	get_parent().get_node("Confirm").show()

func _on_Interactable_body_exited(body):
	get_parent().get_node("Confirm").hide()
