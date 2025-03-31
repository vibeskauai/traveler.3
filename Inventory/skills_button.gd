extends Button

func _on_StatsButton_pressed():
	$InventoryPanel.hide()
	$StatsPanel.show()
	$ArmorPanel.hide()
