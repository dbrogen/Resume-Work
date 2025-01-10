class_name Player
extends CharacterBody2D

## Contains the default gravity for the player
@export var gravity = 1;
## Contains the instance of the player's inventory
@export var inventory: Inventory;

##The constant speed of the character
const SPEED: float = 300.0
##The constant jump velocity of the character
const JUMP_VELOCITY: float = -600.0

## direction of movement
var direction;
## creates an instance of the collection channel
var _collection_channel: CollectionChannel = CollectionChannel.get_instance();

## The player has killed an enemy
@warning_ignore("unused_signal")
signal eliminate;
## The player has died
signal dead;
## Emits whenever an item is collected
@warning_ignore("unused_signal")
signal item_collected;

## Enables physics process and inherits the planet's gravity
func _ready() -> void:
	set_physics_process(true);
	gravity = get_parent()._get_gravity();
	floor_block_on_wall = false;

## Sets the player sprite orientation and walking speed and direction with its associated animation
func move(direction):
	if(direction == -1):
		$Sprite.flip_h = true;
	elif(direction == 1):
		$Sprite.flip_h = false;
	
	if direction:
		velocity.x = direction * SPEED;
		$Sprite.play("Walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);
		$Sprite.play("Idle")

## Handles the jump
func jump():
	velocity.y = JUMP_VELOCITY / gravity;

## Handles if the player is idle
func idle():
	$Sprite.play("Idle");

## Handles the player's input
func _input(event):
	if(event.is_action("up") and is_on_floor()):
		jump();
	if(event.is_action("left") or event.is_action("right")):
		direction = Input.get_axis("left", "right");
		move(direction);
	else:
		idle();

## Handles player gravity and if they are jumping or falling playing the appropriate animations
func _physics_process(delta: float) -> void:
	## Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if((velocity.y > 0) and (not is_on_floor())):
		$Sprite.play("Falling");
	elif ((velocity.y < 0) and (not is_on_floor())):
		$Sprite.play("Jumping");
	if(velocity.y == 0 and velocity.x == 0):
		$Sprite.play("Idle");
	elif(velocity.y == 0 and velocity.x > 0):
		move(1);
	elif(velocity.y == 0 and velocity.x < 0):
		move(-1)
	
	move_and_slide()

## When the rocket takes off hide the player and lock movement
func _on_rocket_takeoff() -> void:
	self.hide();
	set_physics_process(false);

## Play the dead animation and clear the inventory the player dies and emit the signal that the player died
func _on_death_zone_body_entered(_body: Node2D) -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();	

## Handles the collecting of items to the inventory and for collection quests.
func collect(item: Inventory_Item):
	inventory.insert(item);
	print(str("Added to Inventory " + item.name));
	_collection_channel.item_collected.emit(item)

##Patrol Enemy Eliminations (any number) kill the player
func _on_patrol_enemy_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();

##Patrol Enemy Dead (any number) kill the enemy
func _on_patrol_enemy_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_2_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2

func _on_patrol_enemy_2_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();
	
func _on_patrol_enemy_3_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_3_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();

func _on_patrol_enemy_4_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_4_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();

func _on_patrol_enemy_5_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_5_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();

func _on_patrol_enemy_7_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_7_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();

func _on_patrol_enemy_8_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_8_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();

func _on_patrol_enemy_6_dead() -> void:
	self.velocity.y = JUMP_VELOCITY / 2;

func _on_patrol_enemy_6_eliminate() -> void:
	$Sprite.play("Dead");
	set_physics_process(false);
	inventory.clear();
	dead.emit();	
