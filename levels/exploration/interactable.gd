extends Area

export(NodePath) var interaction

func _enter_tree():

	get_parent().get_node("Confirm").hide()
	get_parent().get_node("Label").hide()
	get_parent().get_node("GlitchShader/Glitch").hide()

func _exit_tree():	
	get_parent().get_node("Label").hide()
	get_parent().get_node("GlitchShader/Glitch").hide()
	
func _process(delta):
	$Sprite.rotate_y(delta * rot_speed)
	show()

func _input(event):
	if event.is_action_pressed("confirm") && len(get_overlapping_bodies()) > 0:
		get_node(interaction).run()

func _on_Interactable_body_entered(body):
	get_parent().get_node("Confirm").show()

func _on_Interactable_body_exited(body):
	get_parent().get_node("Confirm").hide()

func show():
	if len(get_overlapping_bodies()) > 0:
		get_parent().get_node("Label").show()
		get_parent().get_node("GlitchShader/Glitch").show()
	else:
		get_parent().get_node("Label").hide()
		get_parent().get_node("GlitchShader/Glitch").hide()
