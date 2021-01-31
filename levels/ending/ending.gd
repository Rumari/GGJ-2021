extends Control

func _on_Text_closed():
	Global.level = 5
	Global.goto_scene_from_path("res://levels/titlescreen/titlescreen.tscn")
