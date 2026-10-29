@tool
extends PanelContainer

@export var cell_height: int:
	set(value):
		cell_height = value

@export var cell_width: int:
	set(value):
		cell_width = value

@export var birth : Array = [2, 3]
@export var Survive : Array = [3]

var amount = 0

@onready var stylebox = get_theme_stylebox("panel")
@onready var label = $Label
@onready var col = $StaticBody2D/CollisionShape2D
@onready var detection_area = $Area2D/CollisionShape2D
@onready var state = $StaticBody2D
@onready var monitor = $Area2D

func _ready():
	#stylebox = get_theme_stylebox("panel").duplicate()
	#stylebox.bg_color = Color(my_color.r, my_color.g, my_color.b, alpha)
	cell_height = get_parent().cell_height
	cell_width = get_parent().cell_width
	col.position = Vector2(cell_width/2, cell_height/2)
	detection_area.position = col.position
	Global.ticked.connect(_check)


func _check():
	_match_state()
	for i in monitor.get_overlapping_bodies():
		if i.state == 1 and i != state:
			amount += 1
	label.text = "Amt: " + str(amount)
	#print("yo we got these dudes for: ", amount)
	amount = 0

func _match_state():
	match state.state:
		0: self_modulate = Color(0, 0, 0)
		1: self_modulate = Color(1, 1, 1)


func _on_button_pressed() -> void:
	if state.state == 0:
		state.state = 1
	else:
		state.state == 0
