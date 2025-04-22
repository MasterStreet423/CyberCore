extends Control

@onready var http = $HTTPRequest
@onready var llmManager = LLMControl.new(http, Global.provider, Global.api_key)
var button = load("res://scenes/elements/option.tscn")
var messages = []
var isLoading = false
const MAX_CHOICES = 4
func _ready() -> void:
	$send.connect("pressed", func (): get_response($LineEdit.text))
	$back.connect("pressed", func (): get_tree().change_scene_to_file("res://scenes/main_menu.tscn"))
	$LineEdit.connect("text_submitted", func (text): get_response(text))
	await $popup.confirm
	set_loading(true)
	var response = await llmManager.generate([])
	set_loading(false)
	messages.append(
		Message.new("model", response.story)
	)
	set_choices(response)


func clear_ui():
	$LineEdit.text = ""
	$ScrollContainer/history.text = ""
	var children = $VBoxContainer.get_children()
	for child in children:
		child.queue_free()

func get_response(message: String):
	clear_ui()
	messages.append(
		Message.new("user","El usuario decide: %s" % message)
	)
	set_loading(true)
	var response = await llmManager.generate(messages)
	set_loading(false)
	messages.append(
		Message.new("model", response.story)
	)
	set_choices(response)

func set_choices(response: Dictionary):
	$ScrollContainer/history.text = response.story 

	for option in response.choices.slice(0,MAX_CHOICES):
		var option_node = button.instantiate()
		option_node.connect("pressed", func (): get_response(option))
		option_node.text = option
		$VBoxContainer.add_child(option_node)

func set_loading(loading: bool):
	if loading:
		$send.disabled = true
		$ScrollContainer/history.add_theme_font_size_override("font_size",50)
		$ScrollContainer/history/AnimationPlayer.play("loading")
	else:
		$send.disabled = false
		$ScrollContainer/history.remove_theme_font_size_override("font_size")
		$ScrollContainer/history/AnimationPlayer.stop()
		
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
