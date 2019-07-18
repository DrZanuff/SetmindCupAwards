extends Node

var link = "http://www.setmind.com.br/img/7mindLogo.png"

func _on_Button_pressed():
	$HTTPRequest.request(link)
	pass # Replace with function body.



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	
	var b = body as PoolByteArray
	$Label.text = str(headers )
	
	var img = Image.new()
	img.load_png_from_buffer(b)
	var new_img = ImageTexture.new()
#	new_img.set_data(img)
	$TextureRect.texture = new_img
#	img.save_png("res://img.png")
#	yield(get_tree().create_timer(5),"timeout")
#	$TextureRect.texture = load("res://img.png")
#	$Label.text = "done"
	pass # Replace with function body.

