class_name InventoryUISlot
extends Panel

##Sets the visual of the item as a Sprite2D
@onready var item_visual: Sprite2D = $CenterContainer/Panel/Item_Display;
##Sets the text of the panel label
@onready var amount_text: Label = $CenterContainer/Panel/Label;

## Updates the inventory slot if there is an inventory item in the slot
func update(slot: Inventory_Slot):
	if(not slot.item):
		item_visual.visible = false;
		amount_text.visible = false;
	else:
		item_visual.visible = true;
		item_visual.texture = slot.item.texture;
		if(slot.amount > 1):
			amount_text.visible = true;
		amount_text.text = str(slot.amount);
