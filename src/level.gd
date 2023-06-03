extends Node3D
class_name TacticsLevel

enum WIN_LOSE {WIN, LOSE, UNDECIDED}

var t_from = null
var t_to = null
var curr_t = null
var player : TacticsPlayerController = null
var enemy : TacticsEnemyController
var arena : TacticsArena
var camera : TacticsCamera
var ui_control : TacticsPlayerControllerUI
var turn_counter = 0
var turn_limit = 1
var win_lose = WIN_LOSE.UNDECIDED

func _ready():
	player = $Player
	enemy = $Enemy
	arena = $Arena
	camera = $TacticsCamera
	ui_control = $PlayerControllerUI
	player.configure(arena, camera, ui_control)
	enemy.configure(arena, camera)


func turn_handler(delta):
	if win_lose == WIN_LOSE.UNDECIDED:
		if player.can_act() : player.act(delta)
		elif enemy.can_act() : enemy.act(delta)
		else:
			turn_counter = turn_counter + 1
			player.reset()
			enemy.reset()
			check_win_lose_conditions()

func check_win_lose_conditions():
	if (!player.has_unit_with_hp()) : 
		win_lose = WIN_LOSE.LOSE
		ui_control.set_visibility_of_lose_ui(true)
	elif (!enemy.has_unit_with_hp() or turn_counter >= turn_limit) : 
		win_lose = WIN_LOSE.WIN
		ui_control.set_visibility_of_win_ui(true)
	

func _physics_process(delta):
	turn_handler(delta)

