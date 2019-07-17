extends Node

export (bool)var debug = false
var window_x = 1280

var scrolling = false
var scroll_target = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if debug:
		debug_populate(21)
	pass # Replace with function body.

func _physics_process(delta):
	if debug:
		debug_move(delta)
	
	if scrolling:
		scroll_x(delta)

func scroll_x(delta):
	$Holder.rect_global_position.x = lerp($Holder.rect_global_position.x ,
	scroll_target , 0.05)
	
	#Snaps position
	if abs(scroll_target) - abs($Holder.rect_global_position.x) < 1:
		$Holder.rect_global_position.x = scroll_target
		$TimerScrollX.paused = false

func debug_move(delta):
	if debug:
		var debug_speed = 800
		if Input.is_action_pressed("debug_right"):
			$Holder.rect_global_position.x = clamp(
			$Holder.rect_global_position.x - debug_speed * delta, 
			-($Holder.rect_size.x-window_x) , 0)
		if Input.is_action_pressed("debug_left"):
			$Holder.rect_global_position.x = clamp(
			$Holder.rect_global_position.x + debug_speed * delta, 
			-($Holder.rect_size.x-window_x) , 0)

func debug_populate(x):
	if debug:
		#Populate with garbage template
		var obj = load("res://Debug/BoxExample.tscn")
		for i in range(x):
			var new_obj = obj.instance()
			$Holder.add_child(new_obj)
			new_obj.text = str("Object ", $Holder.get_child_count() )

func _on_TimerScrollX_timeout():
	scroll_target = $Holder.rect_global_position.x - window_x
	scrolling = true
	$TimerScrollX.paused = true
	pass # Replace with function body.
