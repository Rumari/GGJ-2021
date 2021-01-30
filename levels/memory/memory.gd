extends Node2D

const TextBullet = preload("res://levels/memory/text_bullet.tscn")
const Text = preload("res://levels/text.tscn")

var rng = RandomNumberGenerator.new()
var words
var current_first_characters = []
var targeted_bullet = null
var started = false
var stopped = false
var lost = false
var final = false

onready var viewport_size = get_viewport().size

export(String, MULTILINE) var content
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound
export(NodePath) var destroy_on_win

func _ready():
	rng.randomize()
	
	if final:
		$Player.position = viewport_size / 2
		$Player.make_final()
	else:
		$AnimationPlayer.play("fade")		
		$Player.position.x = viewport_size.x / 2
		$Player.position.y = viewport_size.y - $Player.get_rect().size.y / 3
	
	words = []
	
	var lines = content.split("\n", false)
	for line in lines:
		for illegal in [".", ","]:
			line = line.replace(illegal, "") 
		var w = line.split(" ", false)
		for i in w:
			words.append(i.strip_edges().to_upper())

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
	
	if final:
		$FinalPath/Follow.offset = rng.randf_range(0.0, 3000.0)
		bullet.position = $FinalPath/Follow.position
	else:
		bullet.position = Vector2(rng.randi_range(0, viewport_size.x), 0)
	
	var direction = bullet.position.direction_to($Player.position)
	bullet.position -= 20 * direction
	var scalar = clamp(rng.randfn(1), 1 - velocity_bound, 1 + velocity_bound)
	bullet.velocity = direction * average_bullet_velocity * scalar
	$TextBullets.add_child(bullet)
				
func _on_Timer_timeout():
	if !started or stopped:
		return
	
	if len(words) == 0:
		if $TextBullets.get_child_count() == 0:
			# $AnimationPlayer.play_backwards("fade")
			# res://levels/text.tscn
			stopped = true
			var text = Text.instance()
			text.content = content.split("\n")
			get_parent().add_child(text)
			text.connect("closed", self, "_on_Text_closed")
		return
		
	for i in range(len(words)):
		if !current_first_characters.has(words[i][0]):
			spawn_bullet(words[i])
			words.remove(i)
			break


func _on_AnimationPlayer_animation_finished(anim_name):
	if started:
		if lost:
			Global.goto_old()
		else:
			Global.goto_old_and_destroy(destroy_on_win)
		queue_free()
	started = true
	
func _on_Text_closed():
	Global.level += 1
	$AnimationPlayer.play_backwards("fade")
	
func _on_Player_game_over():
	lost = true
	$AnimationPlayer.play_backwards("fade")
