class_name QuestManager
extends Node


## Variables to contain the Collection Quest information across the game
@export var collection_quest_name: String = "";
@export var collection_quest_accepted: bool = false;
var collection_quest_status = Quest.Status.PENDING;
@export var collection_quest_status_name: String = "Unlock";
@export var collectables: Array[String];
@export var current_quest: CollectQuest;
