extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var tl
func _ready():
	tl = $hb/vb/TargetList
	$hb/vb/hb/AddTarget.connect("pressed", self, "add_target")
	tl.connect("item_activated", self, "tl_item_act")
	tl.connect("item_selected", self, "tl_item_act")
	$hb/vb/Save.connect("pressed", target_data, "save_data")
	for f in target_data.target_data.keys():
		tl.add_item(f)
		tl.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func add_target():
	if $hb/vb/hb/new_target.text.length() > 0:
		tl.add_item($hb/vb/hb/new_target.text)
		tl.update()
func tl_item_act(g):
	var data = tl.get_item_text(g)
	$target_edit.gname = data
	$target_edit.popup_centered_minsize()
