extends Popup

onready var player = get_tree().get_root().get_node("Game").get_node("Player")
onready var pause_menu = get_node("PauseMenu")

signal restart_game

func main_menu():
	# return to main menu
	player.set_process_input(false)
	show()
	pause_menu.enabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_ButtonTitlePlay_pressed():
	# start game
	player.set_process_input(true)
	hide()
	pause_menu.enabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_PauseMenu_restart_game():
	emit_signal("restart_game")
