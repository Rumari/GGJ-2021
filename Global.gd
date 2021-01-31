extends Node

var DaBaby = false
var current_scene = null
var old_scene = null
var level = 0
var on_text = false

onready var root = get_tree().get_root()

var destroy_on_load = []

func _ready():
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene_from_path(path):
	goto_scene(ResourceLoader.load(path).instance())
	
func save_old_and_goto_scene(scene):
	root.remove_child(current_scene)
	old_scene = current_scene
	call_deferred("_deferred_goto_scene", scene)
	
func goto_old():
	goto_scene(old_scene)
	
func goto_old_and_destroy(node):
	destroy_on_load.append(node)
	goto_old()
	
func goto_scene(scene):
	root.remove_child(current_scene)
	current_scene.queue_free()
	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene):
	current_scene = scene
	root.add_child(current_scene)
	get_tree().set_current_scene(current_scene)

	for np in destroy_on_load:
		get_node(np).queue_free()
	destroy_on_load.clear()
