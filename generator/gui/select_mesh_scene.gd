extends PopupDialog
signal complete
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var meshes = []
var mesh_name
var mesh_data
func _ready():
	$vbox/Button.connect("pressed", self, "finalize")
	connect("about_to_show", self, "prep")
	$vbox/ItemList.connect("item_selected", self, "selected")
	$vbox/ItemList.connect("item_activated", self, "selected")
	$vbox/Button.disabled = true
func prep():
	$vbox/ItemList.clear()
	for k in meshes:
		$vbox/ItemList.add_item(k.name)
func selected(g):
	$vbox/Button.disabled = false
	mesh_name = $vbox/ItemList.get_item_text(g)
	for k in meshes:
		if k.name == mesh_name:
			mesh_data = k

func finalize():
	if $vbox/ItemList.is_anything_selected():
		emit_signal("complete", mesh_name, mesh_data)
		hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
