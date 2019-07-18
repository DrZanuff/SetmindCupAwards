extends Node

export (bool)var debug = false
var window_x = 1280

var scrolling = false
var scroll_target = 0
onready var wait = $TimerScrollX.wait_time
onready var holder = $Holder

# Called when the node enters the scene tree for the first time.
func _ready():
	$DebugCam.current = debug
	if debug:
		debug_populate(21)
	pass # Replace with function body.

func _physics_process(delta):
	if debug:
		debug_move(delta)
	
	if scrolling:
		scroll_x(delta)
	
	if Input.is_action_just_pressed("ui_select") and !scrolling:
		start_scroll()

func scroll_x(delta):
	$Holder.rect_global_position.x = lerp($Holder.rect_global_position.x ,
	scroll_target , 0.05)
	
	#Snaps position
	if (abs(scroll_target) - abs($Holder.rect_global_position.x) < 1) or \
	(Input.is_action_just_pressed("ui_select")):
		$Holder.rect_global_position.x = scroll_target
		reoder()
		$TimerScrollX.paused = false
		scrolling = false
		
		
func reoder():
	for i in range(4):
		var obj = $Holder.get_child(0)
		$Holder.remove_child( $Holder.get_child(0) )
		$Holder.add_child(obj)
	$Holder.rect_global_position.x = 0
	pass

func debug_move(delta):
	if debug:
		var debug_speed = 800
		if Input.is_action_pressed("debug_right"):
			$DebugCam.global_position.x += delta * debug_speed
#			$Holder.rect_global_position.x = clamp(
#			$Holder.rect_global_position.x - debug_speed * delta, 
#			-($Holder.rect_size.x-window_x) , 0)
		if Input.is_action_pressed("debug_left"):
			$DebugCam.global_position.x -= delta * debug_speed
#			$Holder.rect_global_position.x = clamp(
#			$Holder.rect_global_position.x + debug_speed * delta, 
#			-($Holder.rect_size.x-window_x) , 0)

func debug_populate(x):
	if debug:
		#Populate with garbage template
		var obj = load("res://Debug/BoxExample.tscn")
		for i in range(x):
			var new_obj = obj.instance()
			$Holder.add_child(new_obj)
			new_obj.text = str("Object ", $Holder.get_child_count() )

func _on_TimerScrollX_timeout():
	start_scroll()

func start_scroll():
	$TimerScrollX.wait_time = wait
	scroll_target = $Holder.rect_global_position.x - window_x
	scrolling = true
	$TimerScrollX.paused = true
