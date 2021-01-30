extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Timer_timeout():
	$DaBaby.show()
	Global.DaBaby = true

func _on_Start_pressed():
	get_tree().change_scene("res://levels/exploration/exploration.tscn")

func _on_Exit_pressed():
	get_tree().quit()
