extends Node
class_name ExperienceManager

const minLevelBonus:float = 1.5
const maxLevelBonus:float = 0.5

static func AwardExperience(amount:int, party:Array[Node]):
	# Grab a list of all of the rank components from our hero party
	var ranks:Array[Rank] = []
	for unit in party:
		var r:Rank = unit.get_node("Rank")
		if(r != null):
			ranks.append(r)
	
	# Step 1: determine the range in actor level stats
	var min:int = 999999 
	var max:int = -999999
	
	for rank in ranks:
		min = min(rank.LVL, min)
		max = max(rank.LVL, max)
		
	# Step 2: weight the amount to award per actor based on their level
	var weights:Array[float] = []
	weights.resize(ranks.size())
	var summedWeights:float = 0
	
	for i in ranks.size():
		var percent:float = (float)(ranks[i].LVL - min + 1) / (float)(max - min + 1)
		weights[i] = lerp(minLevelBonus, maxLevelBonus, percent)
		summedWeights += weights[i]
		
	# Step 3: hand out the weighted award
	for i in ranks.size():
		var subAmount:int = floori((weights[i] / summedWeights) * amount)
		ranks[i].EXP += subAmount
