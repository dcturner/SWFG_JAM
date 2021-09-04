extends Node


# Layout constants
const mid:float = 0.5 # middle of the screen
const div:float = 0.25 # point radius from middle
const mouse_click_thresh:float = 0.1

# point positions
const pos_t = Vector2( mid,  div)		# top
const pos_r = Vector2( mid+div, mid)	# right
const pos_b = Vector2( mid,  mid+div)	# bottom
const pos_l = Vector2( div, mid)		# left

func BPoint(_index, _pos, _h_in, _h_out):
	return {
		index =  _index,
		x = _pos.x,
		y = _pos.y,
		scl = 1.0,
		col = Vector3(1.0,1.0,1.0),
	}


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
