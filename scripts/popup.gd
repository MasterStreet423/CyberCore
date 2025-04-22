extends Panel

signal confirm


var tones = Global.tones.keys()
func _ready():
	self.show()
	$tone_list.clear()
	for tone in tones:
		$tone_list.add_item(tone)
	$confirm.connect("pressed", save_story)

	
func save_story():
	Global.story = $story_text.text
	print(Global.story)
	Global.tone = tones[$tone_list.get_selected_items()[0]]
	self.hide()
	emit_signal("confirm")

