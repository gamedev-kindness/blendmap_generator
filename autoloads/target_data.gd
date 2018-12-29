extends Node

var target_data = {}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func save_data():
	var f = File.new()
	f.open("user://targets.dat", f.WRITE)
	f.store_var(target_data)
	f.close()

func load_data():
	var f = File.new()
	f.open("user://targets.dat", f.READ)
	if f.is_open():
		target_data = f.get_var()
		f.close()
