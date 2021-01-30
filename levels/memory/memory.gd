extends Node2D

const TextBullet = preload("res://levels/memory/text_bullet.tscn")

var rng = RandomNumberGenerator.new()
var words
var current_first_characters = []
var targeted_bullet = null

onready var viewport_size = get_viewport().size

export(String, MULTILINE) var paragraph
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound
export(NodePath) var destroy_on_win

func _ready():
	rng.randomize()
	
	$Player.position.x = viewport_size.x / 2
	$Player.position.y = viewport_size.y - $Player.get_rect().size.y / 2
	
	for illegal in [".", ","]:
		paragraph = paragraph.replace(illegal, "")
	words = paragraph.split(" ", false)
	for i in range(len(words)):
		words[i] = words[i].strip_edges().to_upper()
		
func _input(event):
	if event is InputEventKey and event.pressed:
		if 65 <= event.scancode and event.scancode <= 90: # A to Z
			var chr = char(event.scancode)
			if targeted_bullet == null:
				for bullet in $TextBullets.get_children():
					match bullet.enter_character(chr):
						0:
							continue
						1:
							bullet.select()
							targeted_bullet = bullet
							current_first_characters.erase(chr)
							break
						2:
							current_first_characters.erase(chr)
							break
			elif targeted_bullet.enter_character(chr) == 2:
				targeted_bullet = null

func spawn_bullet(word):
	current_first_characters.append(word[0])
	
	var bullet = TextBullet.instance()
	bullet.text = word
	bullet.position = Vector2(rng.randi_range(0, viewport_size.x), 0)
	
	var direction = bullet.position.direction_to($Player.position)
	var scalar = clamp(rng.randfn(1), 1 - velocity_bound, 1 + velocity_bound)
	bullet.velocity = direction * average_bullet_velocity * scalar
	$TextBullets.add_child(bullet)
				
func _on_Timer_timeout():
	if len(words) == 0:
		if $TextBullets.get_child_count() == 0:
			Global.goto_old_and_destroy(destroy_on_win)
			queue_free()
		return
		
	for i in range(len(words)):
		if !current_first_characters.has(words[i][0]):
			spawn_bullet(words[i])
			words.remove(i)
			break
