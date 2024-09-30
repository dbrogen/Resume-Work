extends CharacterBody2D

@export var speed = 20;
@export var direction = 1; #1 faces right -1 faces left

signal stomped;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity.x = speed;
	if(direction == 1):
		$AnimatedSprite2D.flip_h = false;
		$RayCast2D.position.x = $CollisionShape2D.shape.get_size().x / 2 * direction;
	else:
		$AnimatedSprite2D.flip_h = true;
		$RayCast2D.position.x = $CollisionShape2D.shape.get_size().x / 2 * direction;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(not is_on_floor()):
		velocity += get_gravity() * delta;
		
	#change direction if there is no floor in front of us
	if(not $RayCast2D.is_colliding() and is_on_floor()):
		direction = direction * -1;
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h;
		$RayCast2D.position.x = $CollisionShape2D.shape.get_size().x / 	2 * direction;
	
	if(direction == 1):
		velocity.x = speed;
	else:
		velocity.x = -speed;
	
	move_and_slide();


func _on_stomp_area_body_entered(body: Node2D) -> void:
	print("Stomped on");
	self.hide();
	$CollisionShape2D.set_deferred("disabled", true);
	stomped.emit();
