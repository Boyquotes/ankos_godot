extends Spatial

var rng_shader = preload("res://Shaders/random_alive_render.shader")
var conway_shader = preload("res://Shaders/conway.shader")
var globe_shader = preload("res://Shaders/globe.shader")
var noise_shader = preload("res://Shaders/noisetest.shader")
var current_render
var render_once = false

export var auto: bool

onready var sim_viewport = get_node("Viewport")
onready var sim_sprite = sim_viewport.get_node("Simulation")

func _ready():
	sim_sprite.material.shader = rng_shader
	current_render = "globe"

func _on_step():
	if auto:
		sim_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	else:
		sim_viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	render_once = true
