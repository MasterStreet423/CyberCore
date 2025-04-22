extends Control

func _ready():
	
	var model_list = get_model_list()

	$model_selector.clear()
	for model in model_list:
		$model_selector.add_item(model)
	var provider = Global.provider
	var api_key = Global.api_key
	var llm_model = Global.model
	var language = Global.language
	
	$provider_selector.select(provider)
	$api_key.text = api_key
	$model_selector.select(llm_model)
	$language.text = language
	
	$save.connect("pressed", func (): save_config())
	$back.connect("pressed", func (): get_tree().change_scene_to_file("res://scenes/main_menu.tscn"))
	$provider_selector.connect("item_selected", update_models)

func save_config():
	Global.provider = $provider_selector.get_selected_items()[0]
	Global.api_key = $api_key.text;
	Global.model = $model_selector.get_selected_items()[0];
	Global.language = $language.text;
	Global.save_config()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func get_model_list():
	if Global.provider == LLMControl.LLMProvider.GOOGLE:
		return Global.google_models
	elif Global.provider == LLMControl.LLMProvider.OPENAI:
		return Global.openai_models

func update_models(_provider):
	$model_selector.clear()
	Global.provider = _provider
	var model_list = get_model_list()
	for model in model_list:
		$model_selector.add_item(model)
	
	$model_selector.select(Global.model)
	

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_GO_BACK_REQUEST:
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
