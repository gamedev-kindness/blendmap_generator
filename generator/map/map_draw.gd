extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var tris = []
func _draw():
	draw_rect(Rect2(0, 0, rect_size.x, rect_size.y), Color(0.5, 0.5, 0.5, 1.0), true)
	for t in tris:
		var uvs = t[0]
		var data = t[1]
		var colors = []
		for vec in data:
			colors.push_back(Color(vec.x, vec.y, vec.z))
		draw_polygon(uvs, colors, PoolVector2Array(), null, null, true)
	