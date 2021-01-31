extends Node2D

const TextBullet = preload("res://levels/memory/text_bullet.tscn")
const Text = preload("res://levels/text.tscn")

const FinishWordFX = preload("res://fx/finish_word.wav")
const StartFX = preload("res://fx/start_memory.wav")
const WinFX = preload("res://fx/placeholder.wav")

signal win
signal game_over

var rng = RandomNumberGenerator.new()
var words
var current_first_characters = []
var targeted_bullet = null
var started = false
var stopped = false
var lost = false
var final = false
var time = 0.0
var tutorial = null

onready var viewport_size = get_viewport().size

export(String, MULTILINE) var content
export(String, MULTILINE) var tutorial_content
export(String, MULTILINE) var hidden_content
export(float) var average_bullet_velocity
export(float, 0, 1) var velocity_bound
export(float, 0.1, 10) var bullet_freq = 1
export(float) var duration = 10.0
export(NodePath) var destroy_on_win

func _ready():
	rng.randomize()
	
	if final:
		started = true
		$AudioStreamPlayer.stream = load("res://music/finalboss.ogg")
		$AudioStreamPlayer.play()
		$Player.position = viewport_size / 2
		$Player.make_final()
		$Transition/ColorRect.hide()
	else:
		$Player.position.x = viewport_size.x / 2
		$Player.position.y = viewport_size.y - $Player.get_rect().size.y / 3
		$AnimationPlayer.play("fade")
		
	words = []
	
	var hidden_lines = hidden_content.split("\n", false)
	var lines = content.split("\n", false)
	for line in (lines + hidden_lines):
		for illegal in [".", ",", "?", "!"]:
			line = line.replacen(illegal, " ") 
		var w = line.split(" ", false)
		for i in w:
			var f = i.strip_edges().to_upper()
			print_debug("\"", f, "\"")
			words.append(f)

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
							$AudioStreamPlayer2D.set_stream(FinishWordFX)
							$AudioStreamPlayer2D.play()
							break
			elif targeted_bullet.enter_character(chr) == 2:
				targeted_bullet = null
				$AudioStreamPlayer2D.set_stream(FinishWordFX)
				$AudioStreamPlayer2D.play()

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
				
func _process(delta):
	time += delta
	duration -= delta
	
	if !started or stopped:
		return

	if time >= 1.0 / bullet_freq:
		time = 0.0
		
		if duration < 0.0:
			if $TextBullets.get_child_count() == 0:
				stopped = true
				var text = Text.instance()
				text.content = content.split("\n")
				$Text.add_child(text)
				text.connect("closed", self, "_on_Text_closed")
				$AudioStreamPlayer2D.set_stream(WinFX)
				$AudioStreamPlayer2D.play()
			return
			
		var i = rng.randi_range(0, len(words) - 1)
		if !current_first_characters.has(words[i][0]):
			spawn_bullet(words[i])
		else:
			for j in range(len(words)):
				if !current_first_characters.has(words[j][0]):
					spawn_bullet(words[j])
					break

func _on_AnimationPlayer_animation_finished(anim_name):
	if started:
		if !final:
			if lost:
				Global.goto_old()
			else:
				Global.goto_old_and_destroy(destroy_on_win)
		else:
			if lost:
				emit_signal("game_over")
			else:
				emit_signal("win")
		queue_free()
	else:
		if Global.level == 0:
			# Show tutorial
			tutorial = Text.instance()
			tutorial.content = tutorial_content.split("\n")
			$Text.add_child(tutorial)
			tutorial.connect("closed", self, "_on_Tutorial_closed")
		else:
			started = true
			$AudioStreamPlayer2D.set_stream(StartFX)
			$AudioStreamPlayer2D.play()
	
func _on_Text_closed():
	Global.level += 1
	$AnimationPlayer.play_backwards("fade")
	$Transition/ColorRect.show()

func _on_Tutorial_closed():
	started = true
	tutorial.queue_free()
	$AudioStreamPlayer2D.set_stream(StartFX)
	$AudioStreamPlayer2D.play()
	
func _on_Player_game_over():
	lost = true
	$AnimationPlayer.play_backwards("fade")
	$Transition/ColorRect.show()
