extends Interactable

signal step

func interact():
	emit_signal("step")
	
