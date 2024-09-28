extends Node

var inventory:Array[Node] = []
var combatants:Array[Node] = []
var _random = RandomNumberGenerator.new()

func _ready():
	_random.randomize()
	CreateItems()
	CreateCombatants()
	await SimulateBattle()

func OnEquippedItem(eq:Equipment, item:Equippable):
	inventory.erase(item.get_parent())
	var message:String = "{0} equipped {1}".format([eq.get_parent().name, item.get_parent().name])
	print(message)

func OnUnEquippedItem(eq:Equipment, item:Equippable):
	inventory.append(item.get_parent())
	var message:String = "{0} un-equipped {1}".format([eq.get_parent().name, item.get_parent().name])
	print(message)

func CreateItem(title:String, type:StatTypes.Stat, amount:int):
	var item:Node = Node.new()
	item.name = title
	var smf:StatModifierFeature = StatModifierFeature.new()
	smf.name = "SMF"
	smf.type = type
	smf.amount = amount
	item.add_child(smf)
	return item

func CreateConsumableItem(title:String, type:StatTypes.Stat, amount:int):
	var item:Node = CreateItem(title,type,amount)
	var consumable:Consumable = Consumable.new()
	consumable.name = "Consumable"
	item.add_child(consumable)
	return item

func CreateEquippableItem(title:String, type:StatTypes.Stat, amount:int, slot:EquipSlots.Slot):
	var item:Node = CreateItem(title, type, amount)
	var equip:Equippable = Equippable.new()
	equip.name = "Equippable"
	equip.defaultSlots = slot
	item.add_child(equip)
	return item

func CreateHero():
	var actor:Node = CreateActor("Hero")
	var equipment = Equipment.new()
	equipment.name = "Equipment"
	equipment.EquippedNotification.connect(OnEquippedItem)
	equipment.UnEquippedNotification.connect(OnUnEquippedItem)
	actor.add_child(equipment)
	return actor
	
func CreateActor(title:String):
	var actor:Node = Node.new()
	actor.name = title
	self.add_child(actor)
	var s:Stats = Stats.new()
	s.name = "Stats"
	actor.add_child(s)
	s.SetStat(StatTypes.Stat.MHP, _random.randi_range(500, 1000))
	s.SetStat(StatTypes.Stat.HP, s.GetStat(StatTypes.Stat.MHP))
	s.SetStat(StatTypes.Stat.ATK, _random.randi_range(30, 50))
	s.SetStat(StatTypes.Stat.DEF, _random.randi_range(30, 50))
	return actor
	

func CreateItems():
	inventory.append(CreateConsumableItem("Health Potion",StatTypes.Stat.HP, 300))
	inventory.append(CreateConsumableItem("Bomb",StatTypes.Stat.HP, -150))
	inventory.append(CreateEquippableItem("Sword", StatTypes.Stat.ATK, 10, EquipSlots.Slot.PRIMARY))
	inventory.append(CreateEquippableItem("Broad Sword", StatTypes.Stat.ATK, 15, EquipSlots.Slot.PRIMARY | EquipSlots.Slot.SECONDARY))
	inventory.append(CreateEquippableItem("Shield", StatTypes.Stat.DEF, 10, EquipSlots.Slot.SECONDARY))

func CreateCombatants():
	combatants.append(CreateHero())
	combatants.append(CreateActor("Monster"))

func SimulateBattle():
	while(VictoryCheck() == false):
		LogCombatants()
		HeroTurn()
		EnemyTurn()
		var time_in_seconds = 1
		await get_tree().create_timer(time_in_seconds).timeout
	LogCombatants()
	print("Battle Completed")

func HeroTurn():
	var rnd:int = _random.randi_range(0, 1)
	match(rnd):
		0:
			Attack(combatants[0], combatants[1])
		_:
			UseInventory()

func EnemyTurn():
	Attack(combatants[1],combatants[0])

func Attack(attacker:Node, defender:Node):
	var s1:Stats
	var s2:Stats
	
	for child in attacker.get_children():
		if child is Stats:
			s1 = child
	
	for child in defender.get_children():
		if child is Stats:
			s2 = child
	
	var damage:int = floori((s1.GetStat(StatTypes.Stat.ATK) * 4 - s2.GetStat(StatTypes.Stat.DEF) * 2) * _random.randf_range(0.9,1.1))
	s2.SetStat(StatTypes.Stat.HP, s2.GetStat(StatTypes.Stat.HP) - damage)
	var message:String = "{0} hits {1} for {2} damage!".format([attacker.name, defender.name, damage])
	print(message)

func UseInventory():
	if inventory.size() == 0:
		print("No Inventory")
		return
	var rnd:int = _random.randi_range(0,inventory.size()-1)
	var item:Node = inventory[rnd]
	for child in item.get_children():
		if child is Consumable:
			ConsumeItem(item)
		if child is Equippable:
			EquipItem(item)
	
func ConsumeItem(item:Node):
	inventory.erase(item)
	
	var smf:StatModifierFeature
	var consumable:Consumable
	
	for child in item.get_children():
		if child is StatModifierFeature:
			smf = child
		elif child is Consumable:
			consumable = child
	
	if smf.amount > 0:
		consumable.Consume(combatants[0])
		print("Ah... a potion!")
		
	else:
		consumable.Consume(combatants[1])
		print("Take this you stupid monster!")
		
func EquipItem(item:Node):
	print("Perhaps this will help...")
	var toEquip:Equippable
	for child in item.get_children():
		if child is Equippable:
			toEquip = child
	var equipment:Equipment
	for child in combatants[0].get_children():
		if child is Equipment:
			equipment = child
	equipment.Equip(toEquip,toEquip.defaultSlots)
	
func VictoryCheck():
	for combatant in combatants:
		for child in combatant.get_children():
			if child is Stats:
				if child.GetStat(StatTypes.Stat.HP) <= 0:
					return true
	return false	
		
func LogCombatants():
	print("============")
	for combatant in combatants:
		LogToConsole(combatant)
	print("============")
	
func LogToConsole(actor:Node):
	var s:Stats
	for child in actor.get_children():
		if child is Stats:
			s = child
	var message:String = "Name:{0} HP:{1}/{2} ATK:{3} DEF:{4}".format([actor.name,s.GetStat(StatTypes.Stat.HP),s.GetStat(StatTypes.Stat.MHP),s.GetStat(StatTypes.Stat.ATK),s.GetStat(StatTypes.Stat.DEF)])
	print(message)
