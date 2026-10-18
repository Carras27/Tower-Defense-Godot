class_name Enemigo
extends CharacterBody2D

@export var animacion: AnimatedSprite2D
@export var area_2d: Area2D

var salud: float = 100.0
var speed: float = 0.1
@onready var camino: PathFollow2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemigos")
	animacion.play("default")

func _process(delta):
	if (salud <= 0.0):
		get_parent().queue_free()

func _physics_process(delta):
	camino.progress += speed * delta
	
	if camino.progress_ratio >= 0.99:
		get_parent().queue_free()
	
func take_damage(damage: float):
	salud -= damage
	
