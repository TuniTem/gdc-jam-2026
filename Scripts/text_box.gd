extends ScrollContainer

const TextLabel = preload("res://Scripts/text_label.tscn")

func add_text(text):
	for v in $MarginContainer/VBoxContainer.get_children():
		v.queue_free()
	for t in text:
		var next_label = TextLabel.instantiate()
		$MarginContainer/VBoxContainer.add_child(next_label)
		next_label.text = t
		next_label.show()
