extends Node2D

func _ready():
	$Player.position.x = get_viewport_rect().size.x / 2
	$Player.position.y = get_viewport_rect().size.y - $Player.get_rect().size.y / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

