@tool
extends PanelContainer

@export var cell_height: int:
	set(value):
		cell_height = value

@export var cell_width: int:
	set(value):
		cell_width = value

var alpha: float = 0
var my_color = Color(1, 1, 1)

@onready var stylebox = get_theme_stylebox("panel")
@onready var label = $Label
@onready var col = $StaticBody2D/CollisionShape2D
@onready var detection_area = $StaticBody2D/Area2D/CollisionShape2D

func _ready():
	#stylebox = get_theme_stylebox("panel").duplicate()
	#stylebox.bg_color = Color(my_color.r, my_color.g, my_color.b, alpha)
	cell_height = get_parent().cell_height
	cell_width = get_parent().cell_width
	col.position = Vector2(cell_width/2, cell_height/2)
	detection_area.position = col.global_position
