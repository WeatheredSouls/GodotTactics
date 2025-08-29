extends Node

var step:int = 0
var cursedUnit:Unit
var cursedItem:Equippable

func _ready():
	var turnController = get_node("/root/Battle/Battle Controller/Turn Order Controller")
	turnController.turnCheckNotification.connect(OnTurnCheck)

func OnTurnCheck(target:Unit, exc:BaseException):
	if not exc.toggle:
		return
	
	match step:
		0:
			EquipCursedItem(target)
		1:
			Add(target, "Slow", SlowStatusEffect, 15 )
		2:
			Add(target, "Stop", StopStatusEffect, 150 )
		3:
			Add(target, "Haste", HasteStatusEffect, 15)
		4:
			Add(target, "Blind", BlindStatusEffect, 500)
		_:
			UnEquipCursedItem(target)
		
	step += 1

func Add(target:Unit, effect_name:String, effect:GDScript, duration:int):
	var status:Status = target.get_node("Status")
	var condition:DurationStatusCondition
	condition = status.Add(effect , DurationStatusCondition, effect_name, "Duration Condition")
	condition.duration = 15
	
func EquipCursedItem(target:Unit):
	cursedUnit = target
	
	var obj = Node.new()
	obj.name = "Cursed Sword"
	
	var poisonFeature = AddPoisonStatusFeature.new()
	poisonFeature.name = "Poison Feature"
	obj.add_child(poisonFeature)
	
	cursedItem = Equippable.new()
	cursedItem.name = "Equippable"
	obj.add_child(cursedItem)
	
	var equipment:Equipment = target.get_node("Equipment")
	equipment.Equip(cursedItem, EquipSlots.Slot.PRIMARY )
	
	
func UnEquipCursedItem(target:Unit):
	if target != cursedUnit || step < 10:
		return
	
	var equipment:Equipment = target.get_node("Equipment")
	equipment.UnEquipItem(cursedItem)
	cursedItem.queue_free()
	
	#Once cursed item is removed, we don't need this script anymore
	self.queue_free()
