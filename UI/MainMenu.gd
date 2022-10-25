extends Popup

onready var player = get_tree().get_root().get_node("Game").get_node("Player")

func main_menu():
	player.set_process_input(false)
	popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_ButtonTitlePlay_pressed():
	player.set_process_input(true)
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
