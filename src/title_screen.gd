extends Control


func _on_game_start():
	get_tree().change_scene_to_file("res://assets/tscn/level01/level01level.tscn")
	pass # Replace with function body.


func _on_quit():
	get_tree().quit()
