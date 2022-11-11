extends KinematicBody

signal died

var mouse_sensitivity = 0.1 # u can edit these in options later
var speed = 13
var h_acceleration = 8
var air_acceleration = 2
var normal_acceleration = 8
var gravity = 20
var jump = 13
var full_contact = false #for checking ground slope stuff

var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()

onready var head = $Head
onready var ground_check = $GroundCheck

onready var foot = $Foot
var crouchHeight = 2

onready var headCam = $Head/Camera
onready var mapCam = $MapCam
onready var isHead = true

onready var game = get_tree().get_root().get_node("Game")

func _ready():
	self.connect("died", game, "_on_Player_die")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89)) #stopping you from breaking your neck
		
	if event.is_action_pressed("map"):
		if isHead:
			mapCam.make_current()
			isHead = false
		else:
			headCam.make_current()
			isHead = true
		
func _physics_process(delta):
	
	direction = Vector3()
	
	####################### gravity & jumping ##########################
	full_contact = ground_check.is_colliding()
	
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta
		h_acceleration = air_acceleration
	elif is_on_floor() and full_contact:
		gravity_vec = -get_floor_normal() * gravity
		h_acceleration = normal_acceleration
	else:
		gravity_vec = -get_floor_normal()
		h_acceleration = normal_acceleration
		
	if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding()):
		gravity_vec = Vector3.UP * jump
		
	########################## crouch #################################
	if Input.is_action_just_pressed("crouch"):
			foot.translation.y = foot.translation.y+crouchHeight
	if Input.is_action_just_released("crouch"):
			foot.translation.y = foot.translation.y-crouchHeight

	###################################################################
	####################### direction inputs ##########################
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x
	####################################################################
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_acceleration * delta)
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)

func die():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	emit_signal("died") #later connect to deathscreen
	#queue_free()
	#get_tree().change_scene("res://Game.tscn")
	#get_tree().paused = 

func _on_KillZone_kill(who):
	if (who == get_node("/root/Game/Player")):
		die()
	else:
		who.queue_free()
