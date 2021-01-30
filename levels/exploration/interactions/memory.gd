extends Node

const scene = preload("res://levels/memory/memory.tscn")

export(String, MULTILINE) var memory_text

func run():
    var s = scene.instance()
    s.paragraph = memory_text
    s.destroy_on_win = get_parent().get_path()
    Global.save_old_and_goto_scene(s)
