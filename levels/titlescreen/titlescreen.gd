extends Control

export(Texture) var end_texture
var target = ""

func _enter_tree():
	if Global.level == 5:
		$TextureRect.texture = end_texture
		$AnimationPlayer.play_backwards("fade")
		$ColorRect.show()
		target = ""

func _on_Timer_timeout():
	$DaBaby.show()
	Global.DaBaby = true

func _on_Start_pressed():
	target = "start"
	$AnimationPlayer.play("fade")
	$ColorRect.show()

func _on_Exit_pressed():
	target = "exit"
	$AnimationPlayer.play("fade")
	$ColorRect.show()

func _on_AnimationPlayer_animation_finished(anim_name):
	if target == "start":
		Global.goto_scene_from_path("res://levels/start/start.tscn")
	elif target == "exit":
		get_tree().quit()
	else:
		$ColorRect.hide()

func _on_Start_mouse_entered():
	$FX.play()

func _on_Exit_mouse_entered():
	$FX.play()

func _on_Settings_pressed():
	if Global.easy_mode == true:
		$PopupMenu.set_item_checked(0, true)
	$PopupMenu.popup()

func _on_PopupMenu_id_pressed(id):
	Global.easy_mode = true

func _on_Settings_mouse_entered():
	$FX.play()
