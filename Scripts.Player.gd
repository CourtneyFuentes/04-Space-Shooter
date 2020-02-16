extends KinematicBody2D

export var health = 100
export var score = 0
export var margin = 5
export var y_range = 300
export var acceleration = 0.1

var velocity = Vector2(0,0)

onready var VP = get_viewport_rect().size

onready var Bullets = load("res://Scenes/Bullet.tscn")

signal health_changed
signal score_changed

func _ready():
	emit_signal("health_changed")
	emit_signal("score_changed")

func change_health(h):
	health += h
	emit_signal("health_changed")
	if health <= 0:
		die()

func change_score(s):
	score += s
	emit_signal("score_changed")

func die():
	queue_free()
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func _physics_process(delta):
	if Input.is_action_pressed("fire"):
		var b = Bullets.instance()
		b.position = position
		b.position.y -= 25
		get_node("root/Game/Bullets").add_child(b)
	
	if Input.is_action_pressed("left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("right"):
		velocity.x += acceleration
	if Input.is_action_pressed("up"):
		velocity.y -= acceleration
	if Input.is_action_pressed("down"):
		velocity.y += acceleration
	
	if position.x < margin:
		velocity.x = 0
		position.x = margin
	if position.x > VP.x - margin:
		velocity.x = 0
		position.x = VP.x - margin
	if position.y < margin:
		velocity.y = 0
		position.y = margin
	if position.y > VP.y - margin:
		velocity.y = 0
		position.y = VP.y - margin
		
	var collision = move_and_collide(velocity)
