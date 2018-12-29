extends PopupDialog
signal complete

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
export var caption = "Entry"
var data = ""
func _ready():
	$vbox/hbox/Label.text = caption
	$vbox/hbox/LineEdit.text = data
	$vbox/Button.connect("pressed", self, "finished")

func finished():
	print("complete")
	data = $vbox/hbox/LineEdit.text
	emit_signal("complete", data)
	hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
