extends Area2D

@export var speed := 300


func _ready():
	$FireWaveSound.play()


func _process(delta):
	position += delta * speed * Vector2(0.0, -1.0)


func _on_destroy_timer_timeout():
	queue_free()
