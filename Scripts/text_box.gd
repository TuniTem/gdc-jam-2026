extends ScrollContainer

const TextLabel = preload("res://Scripts/text_label.tscn")

func add_text(text):
	for v in $MarginContainer/VBoxContainer.get_children():
		v.queue_free()
	for t in text:
		var next_label = TextLabel.instantiate()
		$MarginContainer/VBoxContainer.add_child(next_label)
		next_label.text = t
		# next_label.show()
	$TextTimer.start()

func _on_text_timer_timeout():
	for child in $MarginContainer/VBoxContainer.get_children():
		if !child.visible:
			child.show()
			set_deferred("scroll_vertical", 1000)
			return
	$TextTimer.stop()
