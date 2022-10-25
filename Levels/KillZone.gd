extends Area

signal kill(who)

onready var player = get_tree().get_root().get_node("Game").get_node("Player")

func _ready():
	self.connect("body_entered", player, "_on_KillZone_kill")
