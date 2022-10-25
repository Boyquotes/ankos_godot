extends Interactable

export var meshInstancePath : NodePath
onready var meshInstance = get_node(meshInstancePath)

export var spherePath: NodePath
onready var sphere = get_node(spherePath)

const BASE_ANGLE_Y = 0.1
const BASE_ANGLE_Z = 0.01
const BASE_DURATION = 1

var moveAngleY = 0
var moveAngleZ = 0
var duration = 1

func _process(delta):
	# lerp them back to baseline
	moveAngleY = lerp(moveAngleY, BASE_ANGLE_Y, delta/duration)
	moveAngleZ = lerp(moveAngleZ, BASE_ANGLE_Z, delta/duration)
	duration = lerp(duration, BASE_DURATION, delta)
	# spin the sphere
	sphere.rotation_degrees.y = sphere.rotation_degrees.y + moveAngleY
	sphere.rotation_degrees.z = sphere.rotation_degrees.z + moveAngleZ

func interact():
	# bump move angles
	moveAngleY += 10
	moveAngleZ += 1
	duration += 2
	
