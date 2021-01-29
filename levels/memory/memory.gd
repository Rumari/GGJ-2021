extends Node2D

const TextBullet = preload("res://levels/memory/text_bullet.tscn")

var rng = RandomNumberGenerator.new()
onready var viewport_size = get_viewport().size

# export(float, 180) var spawn_angle
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound

func _ready():
    $Player.position.x = viewport_size.x / 2
    $Player.position.y = viewport_size.y - $Player.get_rect().size.y / 2
    
    rng.randomize()


func _on_Timer_timeout():
    var text_bullet = TextBullet.instance()
    
    text_bullet.position = Vector2(rng.randi_range(0, viewport_size.x), 0)
    
    var direction = text_bullet.position.direction_to($Player.position)
    var scalar = clamp(rng.randfn(1), 1 - velocity_bound, 1 + velocity_bound)
    text_bullet.velocity = direction * average_bullet_velocity * scalar
    $TextBullets.add_child(text_bullet)
