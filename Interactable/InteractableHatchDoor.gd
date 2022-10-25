extends Interactable

export var meshInstancePath : NodePath
export var isOpen = false

onready var meshInstance = get_node(meshInstancePath)

onready var x = meshInstance.translation.x
onready var y = meshInstance.translation.y
onready var z = meshInstance.translation.z

var zBuffer = 0.55
var rotBuffer = PI/6

func _ready():
	meshInstance.translation = Vector3(x, y, z)

func interact():
	if isOpen:
		close()
	else:
		open()

func open():
	meshInstance.translation = Vector3(x, y+(y/2), z+(z-zBuffer))
	meshInstance.global_rotate(Vector3(1,0,0), (PI/2-rotBuffer))
	isOpen = true

func close():
	meshInstance.translation = Vector3(x, y, z)
	meshInstance.global_rotate(Vector3(1,0,0), -(PI/2-rotBuffer))
	isOpen = false
