extends Popup

onready var player = get_tree().get_root().get_node("Game").get_node("Player")
var already_paused
var selected_menu
onready var resume_button = $Resume
onready var restart_button = $Restart
onready var quit_button = $Quit
export var init_color =  Color.gray
export var hover_color =  Color.greenyellow

signal restart_game

var enabled = false

func _ready():
	resume_button.connect("clicked", self, "resume_button_effect")
	restart_button.connect("clicked", self, "restart_button_effect")
	quit_button.connect("clicked", self, "quit_button_effect")

func _input(event):
	if enabled:
		if not visible:
			######################################################
			####################### menu init ####################
			######################################################
			if Input.is_action_just_pressed("ui_cancel"):
				# Pause game
				already_paused = get_tree().paused
				get_tree().paused = true
				# Reset the popup
				selected_menu = 0
				change_menu_color()
				# Show popup
				player.set_process_input(false)
				popup()
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			########################################################
			####################### menu arrowkeys #################
			########################################################
			if Input.is_action_just_pressed("ui_down"):
				selected_menu = (selected_menu + 1) % 3;
				change_menu_color()
			elif Input.is_action_just_pressed("ui_up"):
				if selected_menu > 0:
					selected_menu = selected_menu - 1
				else:
					selected_menu = 2
				change_menu_color()
			elif Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("ui_cancel"):
				match selected_menu:
					0:
						resume_button_effect()
					1:
						restart_button_effect()
					2:
						quit_button_effect()

func resume_button_effect():
	# Resume game
	if not already_paused:
		get_tree().paused = false
	player.set_process_input(true)
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func restart_button_effect():
	# Restart game
	emit_signal("restart_game")
	get_tree().paused = false
	player.set_process_input(false)
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	enabled = false

func quit_button_effect():
	# Quit game
	get_tree().quit()

func change_menu_color():
	resume_button.color = init_color
	restart_button.color = init_color
	quit_button.color = init_color
	
	match selected_menu:
		0:
			resume_button.color = hover_color
		1:
			restart_button.color = hover_color
		2:
			quit_button.color = hover_color
