extends Control

export(Array, String) var content
export(Font) var font
export(float) var duration
export(float) var speed

signal end
var labels = []
var time = 0

func _ready():
	var offset = 450
	for entry in content:
		var label = Label.new()
		label.add_font_override("font", font)
		label.text = entry
		add_child(label)
		label.margin_top = offset
		offset += 100
		labels.append(label)

func _process(delta):
	time += delta
	$Sprite.frame = int(time * 3) % 4
	for label in labels:
		label.margin_top -= delta * speed
		
	if time > duration:
		emit_signal("end")
