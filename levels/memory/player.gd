extends Node2D

signal game_over

export(Array, Texture) var shield_textures

var final
var health

func _ready():
	health = 3
	$Shield.texture = shield_textures[health - 1]
	
func make_final():
	$Sprite.hide()
	scale *= 0.7

func get_rect():
	return $Sprite.get_rect()

func damage():
	if health == 1:
		emit_signal("game_over")
		$Shield.texture = null
	elif health > 1:
		health -= 1
		$Shield.texture = shield_textures[health - 1]
