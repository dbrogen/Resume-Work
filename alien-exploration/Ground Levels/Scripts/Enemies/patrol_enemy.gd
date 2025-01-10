class_name PatrolEnemy
extends CharacterBody2D

## Variable to determine Enemy Speed
@export var speed = 100;

## Contains the animated sprite of the Enemy Node
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

## The direction the enemy is facing
var direction; 

## Eliminate player signal
signal eliminate;
## Enemy is dead on this emit
signal dead;

## Called when the node enters the scene tree for the first time.
## Sets the Enemys velocity and where the sprite is facing based on the direction
func _ready() -> void:
	floor_block_on_wall = false;
	velocity.x = speed;
	if(direction == 1):
		$AnimatedSprite2D.flip_h = false;
	else:
		$AnimatedSprite2D.flip_h = true;

## Called every frame. 'delta' is the elapsed time since the previous frame.
## Sets the gravity if the Enemy is not on the floor and the speed based on the direction variable
func _physics_process(delta: float) -> void:
	if(not is_on_floor()):
		velocity += get_gravity() * delta;
	
	if(direction == 1):
		velocity.x = speed;
	else:
		velocity.x = -speed;
	
	move_and_slide();

## When a player enters this the player dies
func _on_killbox_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print("Player died")
		eliminate.emit();

## When a player enters this the enemy dies
func _on_hitbox_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print("Enemy died");
		self.hide();
		$CollisionShape2D.set_deferred("disabled", true);
		$Killbox/CollisionShape2D.set_deferred("disabled", true);
		$Hitbox/CollisionShape2D.set_deferred("disabled", true);
		dead.emit();
