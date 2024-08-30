extends Area2D

@export var textures: Array[Texture2D]
@export var assign_power_up_position: Array[StringName]
@export var speed: int
var power_up: StringName

signal tractor_beam()

func _ready():
	var rng = RandomNumberGenerator.new()
	
	var choice = rng.randi_range(0, textures.size() - 1)
	$Sprite2D.texture = textures[choice]
	power_up = assign_power_up_position[choice]
	
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-70, -15)
	position = Vector2(random_x, random_y)

func _process(delta):
	position += delta * speed * Vector2(0, 1.0)


func _on_body_entered(body):
	tractor_beam.emit(power_up, body)
	queue_free()
