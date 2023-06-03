extends Control

func _on_new_game_gui_input(_event):
	get_tree().change_scene("/tscn/level01/level01level.tscn")
	pass


func _on_texture_button_pressed():
	get_tree().change_scene("/tscn/level01/level01level.tscn")
	pass # Replace with function body.
