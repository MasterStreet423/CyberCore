extends Node

var provider = LLMControl.LLMProvider.GOOGLE
var story = ""
var tone=""
var tones = {
	"Otaku Girl": 'Act as otaku woman, using word as "baka", "desu ne", "onichan", "senpai", and using faces ascii and emojis kawaii.',
	"Otaku Boy": 'Act as otaku man, using word as "baka", "desu ne", "onichan", "senpai", and using faces ascii and emojis kawaii.',
	"Formal": 'Act as a formal, polite, and respectful person, using word as "sir", "maam", "madam", "mister", "miss", "master", "sir" in respective language',
	"Informal": 'Act as a informal, friendly, and casual person, using word as "hi", "hello", "hey", "howdy", "yo", "greetings", "good morning", "good evening", "good night", "thank you", "please", and using faces ascii and emojis.',
	"NSFW": 'You will tell the story in such a way that it always has to reach a sexual tone or a risqué scene, whether experienced or observed by the protagonist. This should not be forced and should flow naturally.',
	"Chad Mode": 'You will tell the story in such a way that it always has to reach a chad mode tone, whether experienced or observed by the protagonist. This should not be forced and should flow naturally.',
	"Neutral": 'You must act neutrally, without reaching extremes of formality or informality, a neutral tone and easy to understand'
}
var api_key = ""
var model = 0
var temperature = 0.9
var language = ""
var openai_models = [
	"gpt-4o",
	"gpt-4o-mini",
]
var google_models = [
	"gemini-2.0-flash-lite",
	"gemini-2.0-flash",
	"gemini-2.5-pro-exp-03-25",
]




func save_config():
	var file = FileAccess.open("user://data.conf",FileAccess.WRITE)
	file.store_var({
		"provider": provider,
		"api_key": api_key,
		"model": model,
		"temperature": temperature,
		"language": language
	})
	file.close()

func load_config():
	var file = FileAccess.open("user://data.conf", FileAccess.READ)
	if FileAccess.get_open_error() != OK:
		return
	var loaded_data = file.get_var(true)
	if "provider" in loaded_data:
		provider = loaded_data["provider"]
	if "api_key" in loaded_data:
		api_key = loaded_data["api_key"]
	if "model" in loaded_data:
		model = loaded_data["model"]
	if "temperature" in loaded_data:
		temperature = loaded_data["temperature"]
	if "language" in loaded_data:
		language = loaded_data["language"]

func _ready():
	load_config()
