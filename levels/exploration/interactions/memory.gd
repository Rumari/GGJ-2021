extends Node

const scene = preload("res://levels/memory/memory.tscn")

export(String, MULTILINE) var memory_text

func run():
    # Remove the current level
    var root = get_tree().get_root()
    var level = root.get_node("Upstairs")
    root.remove_child(level)
    level.queue_free()

    # Add the next level
    var next_level = scene.instance()
    root.add_child(next_level)
