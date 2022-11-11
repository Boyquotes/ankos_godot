extends MeshInstance

const BASE_ANGLE_Y = 0.2
const BASE_ANGLE_Z = 0.02

func _process(delta):
	# spin the sphere
	rotation_degrees.y = rotation_degrees.y + BASE_ANGLE_Y
	rotation_degrees.z = rotation_degrees.z + BASE_ANGLE_Z
