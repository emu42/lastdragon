extends Control
class_name TacticsPlayerControllerUI


@onready var layout_xbox = load("res://assets/sprites/labels/controls-ui-xbox.png")
@onready var layout_pc = load("res://assets/sprites/labels/controls-ui.png")
var is_joystick = false


func _process(_delta):
	if is_joystick: $HBox/VBox/ControllerHints.texture = layout_xbox
	else: $HBox/VBox/ControllerHints.texture = layout_pc

func get_act(action : String = ""):
	if action == "": return $HBox/Actions
	return $HBox/Actions.get_node(action)

func get_win_act(action : String):
	return $WinUI/Actions.get_node(action)

func get_victory_act(action : String):
	return $VictoryUI/Actions.get_node(action)

func get_lose_act(action : String):
	return $LoseUI/Actions.get_node(action)

func is_mouse_hover_button():
	if $HBox/Actions.visible:
		for action in $HBox/Actions.get_children():
			if action.get_global_rect().has_point(get_viewport().get_mouse_position()): 
				return true
	return false

func update_footer(label):
	$Footer/GoalLabel.text = label

func set_visibility_of_actions_menu(v, p):
	if !$HBox/Actions.visible: $HBox/Actions/Move.grab_focus()
	$HBox/Actions.visible = v
	if v:
		set_visibility_of_win_ui(false)
		set_visibility_of_victory_ui(false)
		set_visibility_of_lose_ui(false)
	if !p : return
	$HBox/Actions/Move.disabled = !p.can_move
	$HBox/Actions/Attack.disabled = !p.can_attack

func set_visibility_of_win_ui(v):
	$WinUI.visible = v
	if v: 
		set_visibility_of_actions_menu(false, false)
		set_visibility_of_victory_ui(false)
		set_visibility_of_lose_ui(false)
	
func set_visibility_of_victory_ui(v):
	$VictoryUI.visible = v
	if v: 
		set_visibility_of_win_ui(false)
		set_visibility_of_actions_menu(false, false)
		set_visibility_of_lose_ui(false)
	
func set_visibility_of_lose_ui(v):
	$LoseUI.visible = v
	if v:
		set_visibility_of_actions_menu(false, false)
		set_visibility_of_win_ui(false)
		set_visibility_of_victory_ui(false)
	
