extends Control


func _on_game_start():
	get_tree().change_scene_to_file("res://assets/tscn/level01/level01level.tscn")
	#get_tree().change_scene_to_file("res://assets/tscn/level02/level02level.tscn")
	#get_tree().change_scene_to_file("res://assets/tscn/level99/level99level.tscn")


func _on_quit():
	get_tree().quit()
