extends Spatial

onready var button = get_node("Switch/StaticBodyCA")
onready var CA = get_node("ShaderMachine")

func _ready():
	button.connect("step", CA, "_on_step")

