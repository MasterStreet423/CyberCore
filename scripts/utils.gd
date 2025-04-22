extends Node


func parse_messages(messages: Array, provider:LLMControl.LLMProvider):
	var parsed_messages = []
	show_messages(messages)
	for message in messages:
		var parsed_message
		if provider == LLMControl.LLMProvider.GOOGLE:
			parsed_message = {
				"role": message.role,
				"parts":[
					{
						"text": message.content
					}
				]
			}
		else:
			parsed_message = {
				"role": message.role,
				"content": message.content
			}
		parsed_messages.append(parsed_message)
	if provider == LLMControl.LLMProvider.GOOGLE:
		return {
			"contents": parsed_messages,
			
	"generationConfig": {
	  "responseMimeType": "application/json",
	  "responseSchema": {
		  "type": "object",
		  "properties": {
			"story": {
			  "type": "string"
			},
			"choices": {
			  "type": "array",
			  "items": {
				"type": "string"
			  }
			}
		  },
		  "required": [
			"story",
			"choices"
		  ]
		},
	},
		}
	elif provider == LLMControl.LLMProvider.OPENAI:
		return {
			"model": Global.openai_models[Global.model],
			"messages": parsed_messages,
			"response_format": {
				"type": "json_schema",
				"json_schema":{
					"name": "modelResponse",
					"strict": true,
					"schema": {
						"type": "object",
						"properties": {
							"story": {
								"type": "string"
							},
							"choices": {
								"type": "array",
								"items": {
									"type": "string"
								}
							}
						}, 
						"required": [
							"story",
							"choices"
						],
		  "additionalProperties": false
					}
				}
			}
		}

func show_messages(messages: Array):
	for message in messages:
		print(message.role + ": " + message.content)