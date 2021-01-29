extends Node2D

const TextBullet = preload("res://levels/memory/text_bullet.tscn")

var rng = RandomNumberGenerator.new()
var words

onready var viewport_size = get_viewport().size

export(String, MULTILINE) var paragraph
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound

func _ready():
    rng.randomize()
    
    $Player.position.x = viewport_size.x / 2
    $Player.position.y = viewport_size.y - $Player.get_rect().size.y / 2
    
    for illegal in [".", ","]:
        paragraph = paragraph.replace(illegal, "")
    words = paragraph.split(" ", false)
    for i in range(len(words)):
        words[i] = words[i].strip_edges()

func _on_Timer_timeout():
    if len(words) == 0:
        if $TextBullets.get_child_count() == 0:
            print_debug('we won!')
            queue_free()
        return
        
    var text_bullet = TextBullet.instance()
    
    var i = rng.randi_range(0, len(words) - 1)
    text_bullet.text = words[i]
    words.remove(i)
    
    text_bullet.position = Vector2(rng.randi_range(0, viewport_size.x), 0)
    
    var direction = text_bullet.position.direction_to($Player.position)
    var scalar = clamp(rng.randfn(1), 1 - velocity_bound, 1 + velocity_bound)
    text_bullet.velocity = direction * average_bullet_velocity * scalar
    $TextBullets.add_child(text_bullet)
