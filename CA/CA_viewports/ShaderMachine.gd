extends Spatial

var rng_shader = preload("res://Shaders/randalive.shader")
var conway_shader = preload("res://Shaders/conway.shader")
var current_render
var render_once = false

export var auto: bool

onready var render_sprite = get_node("Render")
onready var sim_viewport = get_node("ViewportContainer").get_node("Viewport")
onready var sim_sprite = sim_viewport.get_node("Simulation")

func _ready():
	sim_sprite.material.shader = rng_shader
	current_render = "rng"
	# The simulation computes the cellular automata, but doesn't draw anything
	# on the screen. The "Render" sprite renders a copy of the simulation.
	render_sprite.texture = sim_viewport.get_texture()

func _on_step():
	if render_once:
		if current_render == "rng":
			sim_sprite.material.shader = conway_shader
			current_render = "conway"
	sim_sprite.texture = sim_viewport.get_texture()
	if auto:
		sim_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	else:
		sim_viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	render_once = true
