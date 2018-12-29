extends PopupDialog
signal complete

var gname = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var base = null
var target = null
enum {
	EMPTY_INPUT,
	BASE_INPUT,
	TARGET_INPUT
}
var input_type = EMPTY_INPUT
func _ready():
	$vb/hb/add_base.connect("pressed", self, "add_base")
	$vb/hb/add_target.connect("pressed", self, "add_target")
	$vb/Close.connect("pressed", self, "complete")
	$open_scene.connect("file_selected", self, "scene_added")
	$select_mesh_scene.connect("complete", self, "add_mesh")
	connect("about_to_show", self, "init_data")

func init_data():
	if target_data.target_data.has(gname):
		base = target_data.target_data[gname].base
		target = target_data.target_data[gname].target
	$vb/Label.text = gname
	if base != null:
		$vb/hb/base_label.text = base.name
	else:
		$vb/hb/base_label.text = ""
	if target != null:
		$vb/hb/target_label.text = target.name
	else:
		$vb/hb/target_label.text = ""

func scene_added(f):
	print(f)
	var data = load(f).instance()
	var queue = [data]
	var mesh_names = []
	while queue.size() > 0:
		var n = queue[0]
		queue.pop_front()
		if n is MeshInstance:
			mesh_names.push_back({"name": n.name, "mesh": n.mesh})
		for r in n.get_children():
			queue.push_back(r)
	print(mesh_names)
	$select_mesh_scene.meshes = mesh_names
	$select_mesh_scene.popup()
func add_base():
	input_type = BASE_INPUT
	$open_scene.popup_centered_minsize(Vector2(300, 300))
func add_target():
	input_type = TARGET_INPUT
	$open_scene.popup_centered_minsize(Vector2(300, 300))
func add_mesh(mesh_name, data):
	print("add ", mesh_name)
	if input_type == BASE_INPUT:
		base = data
		$vb/hb/base_label.text = mesh_name
		$vb/hb/base_label.update()
		$vb/hb.update()
		update()
	elif input_type == TARGET_INPUT:
		target = data
		$vb/hb/target_label.text = mesh_name
		$vb/hb/target_label.update()
		$vb/hb.update()
		update()
#	meshes.push_back(data)
#	$vb/MeshList.add_item(mesh_name)
func complete():
	target_data.target_data[gname] = {"base": base, "target": target}
	print("target data:", target_data.target_data)
	emit_signal("complete", base, target)
	hide()
