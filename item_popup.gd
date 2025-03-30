extends Label

func show_item(slot_data: SlotData, duration := 2.0):
	if not slot_data or not slot_data.item_data:
		return

	text = "%s has been added to your inventory!" % slot_data.item_data.name
	visible = true
	modulate.a = 1.0

	var tween := create_tween()
	tween.tween_interval(duration)
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.tween_callback(Callable(self, "hide"))
