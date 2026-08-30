extends Node

var items = {
	"fists": {
		"png": "res://drawn assets/fist.PNG",
		"type": "tool",
		"toolType": "",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 3
	},
	"logs": {
		"points" : 2,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/log.PNG",
		"scale": 0.08,
	},
	"gold logs": {
		"points" : 8,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/log gold.PNG",
		"scale": 0.08,
	},
	"sticks": {
		"points" : 1,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/stick.PNG",
		"scale": 0.08,
	},
	"gold sticks": {
		"points" : 5,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/stick gold.PNG",
		"scale": 0.08,
	},
	"leafs": {
		"points" : 1,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/leaf.PNG",
		"scale": 0.08,
	},
	"rocks": {
		"points" : 3,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/rock.PNG",
		"scale": 0.08,
	},
	"iron ore": {
		"points" : 7,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/iron stone.PNG",
		"scale": 0.08,
	},
	"smelted iron": {
		"points" : 10,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/iron smelted.PNG",
		"scale": 0.08,
		"desc": "Like Iron ore but is useful on crafting tools and more"
	},
	"wood pickaxe": {
		"points" : 5,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/woodpicaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 1,
		"dmg": 1,
		"dmgMultiplier": 1,
		"cooldown": 2,
		"desc": "A basic picaxe carved from wood. Better than fists, worse than everything else."
	},
	"stone pickaxe": {
		"points" : 15,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/stonePicaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 2,
		"dmg": 2,
		"dmgMultiplier": 5,
		"cooldown": 1.6,
		"desc": "A stone picaxe. Can never be let down by a classic."
	},
	"iron pickaxe": {
		"points" : 30,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/Iron_Picaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 3,
		"dmg": 4,
		"dmgMultiplier": 5,
		"cooldown": 1.4,
		"desc": "An iron picaxe. Able to smash anything and everything. A great tool."
	},
	"wood sword": {
		"points" : 5,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/woodsword.PNG",
		"scale": 0.05,
		"toolType": "damaging",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 3,
		"cooldown": 1.5,
		"desc": "A basic sword carved from wood. Better than fists, worse than everything else."
	},
	"stone sword": {
		"points" : 15,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/stonesword.PNG",
		"scale": 0.05,
		"toolType": "damaging",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 9,
		"cooldown": 1.4,
		"desc": "A stone sword. Can never be let down by a classic."
	},
	"iron sword": {
		"points" : 30,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/Iron_sword.PNG",
		"scale": 0.05,
		"toolType": "damaging",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 15,
		"cooldown": 1.35,
		"desc": "An iron sword. Able to cut through anything and everything. A great tool."
	},
	"wood axe": {
		"points" : 5,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/woodaxe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 1,
		"dmg": 1,
		"dmgMultiplier": 4,
		"cooldown": 1.7,
		"desc": "A basic axe carved from wood. Better than fists, worse than everything else."
	},
	"stone axe": {
		"points" : 15,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/stoneaxe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 2,
		"dmg": 2,
		"dmgMultiplier": 6,
		"cooldown": 1.5,
		"desc": "A stone axe. Can never be let down by a classic."
	},
	"iron axe": {
		"points" : 30,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/Iron_axe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 3,
		"dmg": 5,
		"dmgMultiplier": 5,
		"cooldown": 1.4,
		"desc": "An iron axe. Able to cut down and everything. A great tool."
	},
	"campfire": {
		"points" : 8,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/builds/campfire.PNG",
		"scale": 0.05,
		"desc": "A source of heat in any situation."
	},
	"smelter": {
		"points" : 20,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/builds/furnaceon.PNG",
		"scale": 0.05,
		"desc": "Aids in smelting both food and ore into their ideal states."
	},
	"crafting table": {
		"points" : 15,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/builds/crafter.PNG",
		"scale": 0.05,
		"desc": "For a creative mind, a place to work is all that is needed. A table for more difficult crafts."
	},
	"apple": {
		"points": 5,
		"type": "food",
		"scale": 0.05,
		"png": "res://drawn assets/food/apple.PNG",
		"stackable": true,
		"foodScore": 15,
		"heal": 5,
	},
	"cherry": {
		"points": 3,
		"type": "food",
		"scale": 0.04,
		"png": "res://drawn assets/food/cherry.PNG",
		"stackable": true,
		"foodScore": 8,
		"heal": 3,
	},
	"raw meat": {
		"points": 50,
		"type": "food",
		"scale": 0.05,
		"png": "res://drawn assets/food/uncooked.PNG",
		"stackable": true,
		"foodScore": 25,
		"heal": -20,
	},
	"cooked meat": {
		"points": 75,
		"type": "food",
		"scale": 0.05,
		"png": "res://drawn assets/food/cooked.PNG",
		"stackable": true,
		"foodScore": 40,
		"heal": 15,
		"desc": "Meat. But its not bad for your stomach!"
	},
	"gun": {
		"type": "gun",
		"scale": 0.05,
		"png": "res://drawn assets/tools/gun.PNG",
		"stackable": false,
	}
}

var cratables = {
	"wood sword": {
		"items": {
			"sticks": 15,
		},
		"amount": 1,
		"time": 3,
	},
	"stone sword": {
		"builds": ["crafting table"],
		"items": {
			"sticks": 20,
			"rocks": 12,
		},
		"amount": 1,
		"time": 4,
	},
	"iron sword": {
		"builds": ["crafting table"],
		"items": {
			"gold sticks": 10,
			"smelted iron": 5,
		},
		"amount": 1,
		"time": 8,
	},
	"wood axe": {
		"items": {
			"sticks": 5
		},
		"amount": 1,
		"time": 3,
	},
	"stone axe": {
		"builds": ["crafting table"],
		"items": {
			"sticks": 15,
			"rocks": 8,
		},
		"amount": 1,
		"time": 3,
	},
	"iron axe": {
		"builds": ["crafting table"],
		"items": {
			"gold sticks": 7,
			"smelted iron": 7,
		},
		"amount": 1,
		"time": 4,
	},
	"wood pickaxe": {
		"items": {
			"sticks": 10,
			"logs": 3,
		},
		"amount": 1,
		"time": 3,
	},
	"stone pickaxe": {
		"builds": ["crafting table"],
		"items": {
			"logs": 5,
			"sticks": 5,
			"rocks": 3,
		},
		"amount": 1,
		"time": 4,
	},
	"iron pickaxe": {
		"builds": ["crafting table"],
		"items": {
			"gold sticks": 3,
			"gold logs": 5,
			"smelted iron": 5,
		},
		"amount": 1,
		"time": 5,
	},
	"campfire": {
		"items": {
			"logs": 3,
			"sticks": 8,
			"leafs": 10,
		},
		"amount": 1,
		"time": 2.5,
	},
	"crafting table": {
		"items": {
			"sticks": 5,
			"logs": 1,
			"rocks": 3,
		},
		"amount": 1,
		"time": 5.5,
	},
	"smelter": {
		"items": {
			"rocks": 5,
			"logs": 3,
		},
		"amount": 1,
		"time": 6,
	},
	"cooked meat": {
		"builds": ["campfire"],
		"items": {
			"raw meat": 1,
		},
		"amount": 1,
		"time": 0.7,
	},
	"smelted iron": {
		"builds": ["smelter"],
		"items": {
			"iron ore": 2,
		},
		"amount": 1,
		"time": 1.5,
	},
}

var placeables = {
	"campfire": {
		"scale": 0.12,
		"lifetime": 60,
		"warmth": 15,
		"range": 250,
	},
	"smelter": {
		"scale": 0.15,
		"lifetime": 999999,
		"warmth": 8,
		"range": 300,
	},
	"crafting table": {
		"scale": 0.15,
		"lifetime": 9999999,
		"range": 300,
	},
}

var resourceNodes = {
	"tree": {
		"png": "res://drawn assets/nature&rock/tree.PNG",
		"scale": 1.8,
		"multiDrop": true,
		"drops": {
			"sticks": {
				"chance": 60,
				"minAmount": 1,
				"maxAmount": 2,
			},
			"logs": {
				"chance": 20,
				"minAmount": 1,
				"maxAmount": 1,
			},
			"leafs": {
				"chance": 50,
				"minAmount": 1,
				"maxAmount": 3,
			},
		},
		"hp": 5,
		"dropTimes": 5,
		"toolMult": "axe",
		"damageTier": 0,
	},
	"apple tree": {
		"png": "res://drawn assets/nature&rock/tree apple.PNG",
		"scale": 1.8,
		"multiDrop": true,
		"drops": {
			"apple": {
				"chance": 15,
				"minAmount": 2,
				"maxAmount": 3,
			},
			"sticks": {
				"chance": 60,
				"minAmount": 2,
				"maxAmount": 2,
			},
			"logs": {
				"chance": 20,
				"minAmount": 1,
				"maxAmount": 1,
			},
			"leafs": {
				"chance": 30,
				"minAmount": 2,
				"maxAmount": 4,
			},
		},
		"hp": 20,
		"dropTimes": 6,
		"toolMult": "axe",
		"damageTier": 1,
	},
	"gold tree": {
		"png": "res://drawn assets/nature&rock/three gold.PNG",
		"scale": 1.85,
		"multiDrop": false,
		"drops": {
			"gold logs": {
				"chance": 25,
				"minAmount": 1,
				"maxAmount": 1,
			},
			"gold sticks": {
				"chance": 75,
				"minAmount": 1,
				"maxAmount": 1,
			},
		},
		"hp": 60,
		"dropTimes": 8,
		"toolMult": "axe",
		"damageTier": 2,
	},
	"bush": {
		"png": "res://drawn assets/nature&rock/bush.PNG",
		"scale": 0.9,
		"multiDrop": false,
		"drops": {
			"sticks": {
				"chance": 50,
				"minAmount": 1,
				"maxAmount": 1,
			},
			"leafs": {
				"chance": 100,
				"minAmount": 4,
				"maxAmount": 8,
			}
		},
		"hp": 5,
		"dropTimes": 3,
		"toolMult": "",
		"damageTier": 0,
	},
	"cherry bush": {
		"png": "res://drawn assets/nature&rock/bush cherry.PNG",
		"scale": 1,
		"multiDrop": true,
		"drops": {
			"cherry": {
				"chance": 20,
				"minAmount": 1,
				"maxAmount": 3,
			},
			"sticks": {
				"chance": 60,
				"minAmount": 1,
				"maxAmount": 1,
			},
			"leafs": {
				"chance": 100,
				"minAmount": 3,
				"maxAmount": 4,
			},
		},
		"hp": 9,
		"dropTimes": 9,
		"toolMult": "",
		"damageTier": 0,
	},
	"rock": {
		"png": "res://drawn assets/nature&rock/rock_formation.PNG",
		"scale": 1.7,
		"multiDrop": false,
		"drops": {
			"rocks": {
				"chance": 80,
				"minAmount": 1,
				"maxAmount": 3,
			},
		},
		"hp": 14,
		"dropTimes": 7,
		"toolMult": "pickaxe",
		"damageTier": 1,
	},
	"iron rock": {
		"png": "res://drawn assets/nature&rock/iron recource.PNG",
		"scale": 1.7,
		"multiDrop": true,
		"drops": {
			"iron ore": {
				"chance": 20,
				"minAmount": 1,
				"maxAmount": 2,
			},
			"rocks": {
				"chance": 100,
				"minAmount": 1,
				"maxAmount": 1,
			},
		},
		"hp": 100,
		"dropTimes": 10,
		"toolMult": "pickaxe",
		"damageTier": 2,
	}
}
