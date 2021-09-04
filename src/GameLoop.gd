extends Node2D

# Layout constants
const steps_per_section:int = 100
const lerp_div = 1/ steps_per_section
const mid:float = 0.5 * 1080 # middle of the screen
const div:float = 0.25 * 1080 # point radius from middle
const mouse_click_thresh:float = 0.1

# point positions
const pos_t = Vector2( mid,  div)		# top
const pos_r = Vector2( mid+div, mid)	# right
const pos_b = Vector2( mid,  mid+div)	# bottom
const pos_l = Vector2( div, mid)		# left

var ship_l = 0
var ship_speed = 0.1
var ship_segment = 0
var ship_pos

# top handles
onready var t_in:Node2D = get_node("../handles/top_in")
onready var t_out:Node2D = get_node("../handles/top_out")
# right handles
onready var r_in:Node2D = get_node("../handles/right_in")
onready var r_out:Node2D = get_node("../handles/right_out")
# btm handles
onready var b_in:Node2D = get_node("../handles/btm_in")
onready var b_out:Node2D = get_node("../handles/btm_out")
# left handles
onready var l_in:Node2D = get_node("../handles/left_in")
onready var l_out:Node2D = get_node("../handles/left_out")

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
func _process(delta):
	
	update()
	ship_l += delta * ship_speed
	ship_l = fmod(ship_l,1)
	ship_segment = floor(ship_l * 4)
	print(ship_segment)
	pass

func _draw():
	# T-R segment
	var a = pos_t
	var ao = t_out.global_position
	var b = pos_r
	var bi = r_in.global_position
	draw_section(a,ao,b,bi)
	# update ship
	if(ship_segment == 0):
		ship_pos = get_lerp_pos(a,ao,b,bi, ship_l/0.25)
	
	# R-B segment
	a = pos_r
	ao = r_out.global_position
	b = pos_b
	bi = b_in.global_position
	draw_section(a,ao,b,bi)
	# update ship
	if(ship_segment == 1):
		ship_pos = get_lerp_pos(a,ao,b,bi, (ship_l-0.25)/0.25)
	
	# B-L segment
	a = pos_b
	ao = b_out.global_position
	b = pos_l
	bi = l_in.global_position
	draw_section(a,ao,b,bi)
	# update ship
	if(ship_segment == 2):
		ship_pos = get_lerp_pos(a,ao,b,bi, (ship_l-0.5)/0.25)
		
	# L-T segment
	a = pos_l
	ao = l_out.global_position
	b = pos_t
	bi = t_in.global_position
	draw_section(a,ao,b,bi)
	# update ship
	if(ship_segment == 3):
		ship_pos = get_lerp_pos(a,ao,b,bi, (ship_l-0.75)/0.25)
	
	# Draw points
	draw_circle(pos_t, 5, Color(255,255,255))
	draw_circle(pos_r, 5, Color(255,255,255))
	draw_circle(pos_b, 5, Color(255,255,255))
	draw_circle(pos_l, 5, Color(255,255,255))
	
	# draw ship
	draw_circle(ship_pos, 10, Color(255,255,0))
	
func draw_section(a:Vector2, ao:Vector2, b:Vector2, bi:Vector2):
	var sps : float = steps_per_section * 1.0
	for i in range(1, steps_per_section,1):
		var line_start = get_lerp_pos(a,ao,b,bi, (i-1)/sps)
		var line_end = get_lerp_pos(a,ao,b,bi, i / sps)
		draw_line(line_start, line_end, Color(255,0,0), 1)

func get_lerp_pos(a:Vector2, ao:Vector2, b:Vector2, bi:Vector2, l:float) -> Vector2:
	# round 1
	var ab = lerp(a,b,l)
	var a1 = lerp(a,ao,l)
	var b1 = lerp(bi,b,l)
	
	# round 2
	var a2 = lerp(a1,ab,l)
	var b2 = lerp(ab,b1,l)
	
	# round 3
	return lerp(a2,b2, l)
