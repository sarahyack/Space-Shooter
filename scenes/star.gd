extends Node2D

var speed: int

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng := RandomNumberGenerator.new()
	
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-70, -15)
	position = Vector2(random_x, random_y)
	
	var random_scale = rng.randf_range(.5, 1)
	scale = Vector2(random_scale, random_scale)
	speed = rng.randi_range(20, 50)
	
	$AnimatedSprite2D.self_modulate.a = rng.randf_range(.5, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += delta * speed * Vector2(0, 1.0)
