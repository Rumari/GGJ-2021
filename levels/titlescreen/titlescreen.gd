extends Control

export(Texture) var end_texture

func _enter_tree():
	if Global.level == 5:
		$TextureRect.texture = end_texture

func _on_Timer_timeout():
	$DaBaby.show()
	Global.DaBaby = true

func _on_Start_pressed():
	Global.goto_scene_from_path("res://levels/house/house.tscn")

func _on_Exit_pressed():
	get_tree().quit()
