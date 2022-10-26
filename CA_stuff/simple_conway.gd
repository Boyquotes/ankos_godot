extends Spatial

onready var render_sprite = get_node("Render")
onready var sim_viewport = get_node("ViewportContainer").get_node("Viewport")
onready var sim_sprite = sim_viewport.get_node("Simulation")

var first_frame_rendered = false

func _ready():
	# The simulation computes the cellular automata, but doesn't draw anything
	# on the screen. The "Render" sprite renders a copy of the simulation.
	render_sprite.texture = sim_viewport.get_texture()

func _process(delta):
	if !first_frame_rendered:
		first_frame_rendered = true
	else:
		# After the first frame is rendered, assign viewport back to itself,
		# so that next frame can be computed from the previous.
		sim_sprite.texture = sim_viewport.get_texture()

func _on_StaticBodyCA_step():
	sim_viewport.render_target_update_mode = Viewport.UPDATE_ONCE
