extends Node
class_name UnitFactory

static func InstantiatePrefab(path:String, name:String):
	var prefab:PackedScene = load(path + name + ".tscn")
	if prefab == null:
		print("No Prefab for name: " + name)
		return null
	return prefab.instantiate()

static func Create(name:String,  level:int, _owner:BattleController):
	var recipe:UnitRecipe = load("res://Data/Unit Recipes/" + name + ".tres")
	recipe.resource_name = name
	if recipe == null:
		print("No Unit recipe for name: " + name)
		return null
	
	return CreateRecipe(recipe, level, _owner)

static func CreateRecipe(recipe:UnitRecipe, level:int, _owner:BattleController):
	var obj:Unit = InstantiatePrefab("res://Data/Units/" , recipe.model)
	obj.name = recipe.resource_name
	_owner.add_child(obj)

	AddStats(obj)	
	AddLocomotion(obj, recipe.locomotion)
	AddStatus(obj)	
	AddEquipment(obj)	
	AddJob(obj, recipe.job)
	AddRank(obj, level)		
	AddHealth(obj)	
	AddMana(obj)	
	AddAttack(obj, recipe.attack)
	AddAbilityCatalog(obj, recipe.abilityCatalog)
	AddAlliance(obj, recipe.alliance)
	return obj

static func AddStats(obj:Node):
	var s:Stats = Stats.new()
	obj.add_child(s)
	s.SetStat(StatTypes.Stat.LVL, 1)
	s.name = "Stats"

static func AddStatus(obj:Node):
	var status:Status = Status.new()
	status.name = "Status"
	obj.add_child(status)	

static func AddEquipment(obj:Node):	
	var equipment:Equipment = Equipment.new()
	equipment.name = "Equipment"
	obj.add_child(equipment)
	
static func AddHealth(obj:Node):
	var health:Health = Health.new()
	health.name = "Health"
	obj.add_child(health)

static func AddMana(obj:Node):	
	var mana:Mana = Mana.new()
	mana.name = "Mana"
	obj.add_child(mana)

static func AddJob(obj:Node, name:String):
	var job:Job = InstantiatePrefab("res://Data/Jobs/" , name)
	obj.add_child(job)
	job.Employ()
	job.LoadDefaultStats()

static func AddAlliance(obj:Node, type:AllianceType.Alliances):
	var alliance:Alliance = Alliance.new()
	alliance.name = "Alliance"
	alliance.type = type
	obj.add_child(alliance)

static func AddRank(obj:Node, level:int):
	var rank = Rank.new()
	rank.name = "Rank"
	obj.add_child(rank)
	rank.Init(level)

static func AddLocomotion(obj:Node, type:MoveType.Locomotions):
	var move:Movement

	match type:
		MoveType.Locomotions.Walk:
			move = WalkMovement.new()
		MoveType.Locomotions.Fly:
			move = FlyMovement.new()
		MoveType.Locomotions.Teleport:
			move = TeleportMovement.new()

	obj.add_child(move)
	move.name = "Movement"

static func AddAttack(obj:Node, name:String):
	var abilities = Node.new()
	abilities.name = "Abilities"
	obj.add_child(abilities)
	var attack = InstantiatePrefab("res://Data/Abilities/" , name)
	abilities.add_child(attack)

static func AddAbilityCatalog(obj:Node, name:String):
	var abilities = obj.get_node("Abilities") 
	
	var abilityCatalog:AbilityCatalog = AbilityCatalog.new()
	abilityCatalog.name = "Ability Catalog"
	abilities.add_child(abilityCatalog)
	
	var recipe:AbilityCatalogRecipe = load("res://Data/Ability Catalog Recipes/" + name + ".tres")
	if recipe == null:
		print("No Ability Catalog Recipe Found: " + name)
		return
	
	for i in recipe.categories.size():
		var category:Node = Node.new()
		category.name = recipe.categories[i].name
		abilityCatalog.add_child(category)
		for j in recipe.categories[i].entries.size():
			var path = "res://Data/Abilities/" + recipe.categories[i].name + "/"
			var ability:Ability = InstantiatePrefab(path, recipe.categories[i].entries[j])
			ability.name = recipe.categories[i].entries[j]
			category.add_child(ability)
