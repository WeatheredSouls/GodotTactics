extends Node
class_name AbilityCatalog

# Assumes that all direct children are categories
# and that the direct children of categories
# are abilities

func CategoryCount():
	return self.get_child_count()

func GetCategory(index:int)->Node:
	if (index < 0 || index >= self.get_child_count()):
		return null
	
	var children = self.get_children()
	return children[index]

func AbilityCount(category:Node):
	if category == null:
		return 0
	return category.get_child_count()

func GetAbility(categoryIndex:int, abilityIndex:int):
	var category:Node = GetCategory(categoryIndex)
	if (category == null || abilityIndex < 0 || abilityIndex >= category.get_child_count()):
		return null
	var children = category.get_children()
	return children[abilityIndex]
