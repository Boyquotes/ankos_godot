extends ColorRect

onready var label: Label = $Label
var init_color =  Color.gray
var hover_color =  Color.greenyellow

var inside = false
signal clicked

func _ready():
	connect("mouse_entered", self, "_on_mouseEntered")
	connect("mouse_exited", self, "_on_mouseExited")
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		if inside:
			emit_signal("clicked")

func _on_mouseEntered():
	color = hover_color
	inside = true

func _on_mouseExited():
	color = init_color
	inside = false
