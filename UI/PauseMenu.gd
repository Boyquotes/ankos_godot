extends Popup

onready var player = get_tree().get_root().get_node("Game").get_node("Player")
onready var interactionRay = player.get_node("Head/Camera").get_node("InteractionRayCast")
var already_paused
var selected_menu
onready var interact_button = $ChangeInteractionMode
onready var resume_button = $Resume
onready var restart_button = $Restart
onready var quit_button = $Quit
export var init_color =  Color.gray
export var hover_color =  Color.greenyellow
var number_buttons = 4

signal restart_game

var enabled = false

func _ready():
	interact_button.connect("clicked", self, "interaction_button_effect")	
	resume_button.connect("clicked", self, "resume_button_effect")
	restart_button.connect("clicked", self, "restart_button_effect")
	quit_button.connect("clicked", self, "quit_button_effect")
	if interactionRay.interaction_rapid: interact_button.label.text = "Interaction: Rapid"
	else: interact_button.label.text = "Interaction: Single"

func _input(_event):
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
				selected_menu = (selected_menu + 1) % number_buttons;
				change_menu_color()
			elif Input.is_action_just_pressed("ui_up"):
				if selected_menu > 0:
					selected_menu = selected_menu - 1
				else:
					selected_menu = number_buttons-1
				change_menu_color()
			elif Input.is_action_just_pressed("ui_accept"):
				match selected_menu:
					0: interaction_button_effect()
					1: resume_button_effect()
					2: restart_button_effect()
					3: quit_button_effect()
			elif Input.is_action_just_pressed("ui_cancel"):
				resume_button_effect()

func interaction_button_effect():
	interactionRay.interaction_rapid = !interactionRay.interaction_rapid
	if interactionRay.interaction_rapid: interact_button.label.text = "Interaction: Rapid"
	else: interact_button.label.text = "Interaction: Single"

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
	interact_button.color = init_color
	resume_button.color = init_color
	restart_button.color = init_color
	quit_button.color = init_color
	
	match selected_menu:
		0: interact_button.color = hover_color
		1: resume_button.color = hover_color
		2: restart_button.color = hover_color
		3: quit_button.color = hover_color
