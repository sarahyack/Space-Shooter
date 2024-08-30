extends CanvasLayer

static var image = load("res://Assets/PNG/UI/playerLife1_blue.png")
var title_scene = load("res://scenes/title_screen.tscn")

signal move_buttons_pressed

func _set_health(amount):
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer2/HBoxContainer.add_child(text_rect)


func _on_score_timer_timeout():
	Global.score += 1

func _process(_delta):
	$MarginContainer/Label.text = str(Global.score)
	
	
func _input(event):
	if event.is_action_pressed('return'):
		get_tree().call_deferred('change_scene_to_packed', title_scene)
	if event.is_action_pressed("quit"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
	
