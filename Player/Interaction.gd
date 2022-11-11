extends RayCast

var current_collider

onready var interaction_label = get_node("/root/Game/UI/InteractionLabel")
onready var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)

export var interaction_rapid: bool

func _ready():
	set_interaction_text("")

func _process(_delta):
	var interaction_input: bool
	if interaction_rapid:
		interaction_input = Input.is_action_pressed("interact")
	else:
		interaction_input = Input.is_action_just_pressed("interact")
	
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
		
		if interaction_input:
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text("")

func set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		interaction_label.set_text("Press %s to %s" % [interact_key, text])
		interaction_label.set_visible(true)
