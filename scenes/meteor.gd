extends Area2D

var speed: int
var rotation_speed: int
var direction_x: float
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

signal collision
signal destroyed

func _ready():
	var rng := RandomNumberGenerator.new()
	
	# Randomize Position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	# Randomize Direction
	direction_x = rng.randf_range(-1, 1)
	
	# Randomize Speed
	speed = rng.randi_range(200, 500)
	
	# Randomize Graphics
	var grey_path: String = "res://Assets/PNG/Meteors/meteorGrey_big" + str(rng.randi_range(1,4)) + ".png"
	var brown_path: String = "res://Assets/PNG/Meteors/meteorBrown_big" + str(rng.randi_range(1, 4)) + ".png"
	var key: int = rng.randi_range(1,2)
	$Sprite2D.texture = load(grey_path) if key == 1 else load(brown_path) 
	
	# Handle Rotation
	rotation_speed = rng.randi_range(-100, 100)
	

func _process(delta):
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta

func _on_body_entered(body):
	if body.is_in_group('player'):
		collision.emit()
	if body.is_in_group('borders'):
		queue_free()

func _on_area_entered(area):
	if area.is_in_group('laser'):
		area.queue_free()
	destroyed.emit()
	queue_free()
	Global.score += 10
