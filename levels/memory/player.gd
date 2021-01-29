extends Node2D

signal game_over

export(Array, Texture) var shield_textures

var health

func _ready():
	health = 3
	$Shield.texture = shield_textures[health - 1]	

func get_rect():
	return $Sprite.get_rect()

func damage():
	health -= 1
	if health == 0:
		emit_signal("game_over")
	$Shield.texture = shield_textures[health - 1]
