extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sounds/ShieldUpSound.play()
	$Sprite.play("shield_up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_tree().get_first_node_in_group("player").position


func _on_shield_countdown_timeout():
	$Sounds/ShieldDownSound.play()
	$Sprite.play("shield_down")
	$DestroyTimer.start()


func _on_destroy_timer_timeout():
	queue_free()
