extends Node
class_name Job

const statOrder : Array[StatTypes.Stat] = [
	StatTypes.Stat.MHP, 
	StatTypes.Stat.MMP, 
	StatTypes.Stat.ATK,
	StatTypes.Stat.DEF,
	StatTypes.Stat.MAT,
	StatTypes.Stat.MDF,
	StatTypes.Stat.SPD
	]

@export var baseStats:Array[int]
@export var growStats:Array[float]
var stats:Stats

func _init():
	baseStats.resize(statOrder.size())
	baseStats.fill(0)
	growStats.resize(statOrder.size())
	growStats.fill(0)

	
func Employ():
	for child in self.get_parent().get_children():
		if child is Stats:
			stats = child
	stats.DidChangeNotification(StatTypes.Stat.LVL).connect(OnLvlChangeNotification)	

	var features:Array[Node] = self.get_children()
	
	var filteredArray = features.filter(func(node):return node is Feature)
	for node in filteredArray:
		node.Activate(self.get_parent())
	
func UnEmploy():
	var features:Array[Node] = self.get_parent().get_children()
	
	var filteredArray = features.filter(func(node):return node is Feature)
	for node in filteredArray:
		node.Deactivate()

	stats.DidChangeNotification(StatTypes.Stat.LVL).disconnect(OnLvlChangeNotification)
	stats = null

func LoadDefaultStats():
	for i in statOrder.size():
		stats.SetStat(statOrder[i], baseStats[i], false)
		
	stats.SetStat(StatTypes.Stat.HP, stats.GetStat(StatTypes.Stat.MHP), false)
	stats.SetStat(StatTypes.Stat.MP, stats.GetStat(StatTypes.Stat.MMP), false)

func OnLvlChangeNotification(sender:Stats, oldValue:int):
	var newLevel = stats.GetStat(StatTypes.Stat.LVL)
	for i in range(oldValue, newLevel, 1):
		LevelUp()

func LevelUp():
	for i in statOrder.size():
		var type:StatTypes.Stat = statOrder[i]
		var whole:int = floori(growStats[i])
		var fraction:float = growStats[i] - whole
		var value:int = stats.GetStat(type)
		value += whole
		
		if randf() > (1.0 - fraction):
			value += 1
			
		stats.SetStat(type, value, false)
		
	stats.SetStat(StatTypes.Stat.HP, stats.GetStat(StatTypes.Stat.MHP), false)
	stats.SetStat(StatTypes.Stat.MP, stats.GetStat(StatTypes.Stat.MMP), false)
