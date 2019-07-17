extends Node

var link = "http://www.setmind.com.br/img/7mindLogo.png"

func _on_Button_pressed():
	$HTTPRequest.request(link)
	pass # Replace with function body.



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var img = Image.new()
	var b = body as PoolByteArray
	$Label.text = str(b.get_string_from_ascii() )
	img.load_png_from_buffer(b)
	img.save_png("res://img.png")
	yield(get_tree().create_timer(5),"timeout")
	$TextureRect.texture = load("res://img.png")
	$Label.text = "done"
	pass # Replace with function body.

