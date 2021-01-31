extends Control

func _on_Text_closed():
	Global.level = 0
	Global.goto_scene_from_path("res://levels/house/house.tscn")
