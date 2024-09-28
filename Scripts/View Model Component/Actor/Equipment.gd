extends Node
class_name Equipment

signal EquippedNotification()
signal UnEquippedNotification()

var _items:Array[Equippable]

func Equip(item:Equippable, slots:EquipSlots.Slot):
	UnEquipSlots(slots)
	
	_items.append(item)
	var itemParent:Node = item.get_parent()
	self.add_child(itemParent)
	item.slots = slots
	item.OnEquip()
	EquippedNotification.emit(self, item)

func UnEquipItem(item:Equippable):
	item.OnUnEquip()
	item.slots = EquipSlots.Slot.NONE
	_items.erase(item)
	var itemParent:Node = item.get_parent()
	self.remove_child(itemParent)
	UnEquippedNotification.emit(self, item)
	
func UnEquipSlots(slots:EquipSlots.Slot):
	for i in range(_items.size()-1,-1,-1):
		var item = _items[i]
		if (item.slots & slots) != EquipSlots.Slot.NONE:
			UnEquipItem(item)
