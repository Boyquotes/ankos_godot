extends Spatial

var rng_shader = preload("res://Shaders/randalive.shader")
var conway_shader = preload("res://Shaders/conway.shader")
var globe_shader = preload("res://Shaders/globe.shader")
var noise_shader = preload("res://Shaders/noisetest.shader")
var dummy_shader = preload("res://Shaders/dummy.shader")
var test_shader = preload("res://Shaders/testglobe.shader")
var current_render
var render_once = false

export var auto: bool

onready var sim_viewport = get_node("Viewport")
onready var sim_sprite = sim_viewport.get_node("Simulation")

func _ready():
	sim_sprite.material.shader = globe_shader
	if !render_once:
		_on_step()

func _on_step():
	sim_sprite.texture = sim_viewport.get_texture()
	if auto:
		sim_viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	else:
		sim_viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	render_once = true
