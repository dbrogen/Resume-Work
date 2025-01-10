class_name RedGem
extends StaticBody2D

##Contains the inventory item resource for the scene
@export var item: Inventory_Item;
##The player that collects the item
@export var player = null;

func _on_pickup_area_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		player = body;
		player.collect(item);
		await(get_tree().create_timer(.1)).timeout;
		self.queue_free()
