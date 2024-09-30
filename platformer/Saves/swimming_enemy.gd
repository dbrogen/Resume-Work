extends CharacterBody2D

@export var speed = 60;
@export var direction = 1; #1 faces right -1 faces left

signal stomped;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("Swimming");
	self.velocity.x = speed;
	if(direction == 1):
		$AnimatedSprite2D.flip_h = false;
	else:
		$AnimatedSprite2D.flip_h = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	move_and_slide();


func _on_bumper_1_body_entered(body: Node2D) -> void:
	self.velocity.x = speed;
	print("Bumper 1 Entered");
	$AnimatedSprite2D.flip_h = false;

func _on_bumper_2_body_entered(body: Node2D) -> void:
	self.velocity.x = -speed;
	print("Bumper 2 Entered")
	$AnimatedSprite2D.flip_h = true;


func _on_stomp_area_body_entered(body: Node2D) -> void:
	print("Stomped on");
	self.hide();
	stomped.emit();
