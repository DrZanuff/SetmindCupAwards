extends PanelContainer


func update_data(array,index):
#	index = 0
#	array = [["Melhor Papaco","Melhor Piada"],
#	["Keith -Marvel-","Aliana -Olympo-"],
#	["Guster -Shield-","Anderson Silba -UFC-"],
#	["Guster -Shield-","Anderson Silba -UFC-"],
#	["Guster -Shield-","Anderson Silba -UFC-"],
#	["Guster -Shield-","Anderson Silba -UFC-"],
#	["Guster -Shield-","Anderson Silba -UFC-"], ]
	$Body/Title.text = array[0][index]
	var winner = array[1][index].split(" -")
	if winner.size() > 1:
		$Body/Winner.text = winner[0] + "\n" + winner[1].replace("-","")
	
	for i in range($Body/Nominiees.get_child_count() ):
#		var photo = ""
		var n = $Body/Nominiees.get_child(i).get_node("Info/Nome")
		var t = $Body/Nominiees.get_child(i).get_node("Info/Turma")
		var nominee = array[i+2][index].split(" -")
		if nominee.size() > 1:
			n.text = nominee[0]
			t.text = nominee[1].replace("-","")
	pass