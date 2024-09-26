extends Node
class_name Rank

const minLevel:int = 1
const maxLevel:int = 99
const maxExperience:int = 999999

var stats:Stats

var LVL:int: 
	get:
		return stats.GetStat(StatTypes.Stat.LVL)

var EXP:int:
	get:
		return stats.GetStat(StatTypes.Stat.EXP)
	set(value):
		stats.SetStat(StatTypes.Stat.EXP, value)

var levelPercent:float:
	get:
		return (float)(LVL - minLevel) / (float)(maxLevel - minLevel)

func _ready():
	stats = get_node("../Stats")
	stats.WillChangeNotification(StatTypes.Stat.EXP).connect(OnExpWillChange)
	stats.DidChangeNotification(StatTypes.Stat.EXP).connect(OnExpDidChange)

	
func _exit_tree():
	stats.WillChangeNotification(StatTypes.Stat.EXP).disconnect(OnExpWillChange)
	stats.DidChangeNotification(StatTypes.Stat.EXP).disconnect(OnExpDidChange)

func OnExpWillChange(sender:Stats, vce:ValueChangeException):
	vce.AddModifier(ClampValueModifier.new(999999, EXP, maxExperience))

func OnExpDidChange(sender:Stats, oldValue:int):
	stats.SetStat(StatTypes.Stat.LVL, LevelForExperience(EXP), false)

static func ExperienceForLevel (level: int )->int:
	var levelPercent = clamp( (float)(level - minLevel) / (float)(maxLevel - minLevel), 0, 1)
	return (int)(maxExperience * ease(levelPercent, 2.0))

static func LevelForExperience(exp:int)->int:
	var lvl = maxLevel
	while lvl >= minLevel:
		if(exp >= ExperienceForLevel(lvl)):
			break
		lvl-= 1
	return lvl
		
func Init(level:int):
	stats.SetStat(StatTypes.Stat.LVL, level, false)
	stats.SetStat(StatTypes.Stat.EXP, ExperienceForLevel(level), false)
