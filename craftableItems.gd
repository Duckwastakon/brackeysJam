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
		"points" : 3,
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
		"points" : 2,
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
		"points" : 2,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/rock.PNG",
		"scale": 0.08,
	},
	"iron ore": {
		"points" : 10,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/iron stone.PNG",
		"scale": 0.08,
	},
	"smelted iron": {
		"points" : 15,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/materials/iron smelted.PNG",
		"scale": 0.08,
	},
	"wood pickaxe": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/woodpicaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 1,
		"dmg": 2,
		"dmgMultiplier": 3,
		"cooldown": 2,
	},
	"stone pickaxe": {
		"points" : 30,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/stonePicaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 2,
		"dmg": 3,
		"dmgMultiplier": 4,
		"cooldown": 1.8,
	},
	"iron pickaxe": {
		"points" : 60,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/Iron_Picaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 3,
		"dmg": 3,
		"dmgMultiplier": 5,
		"cooldown": 1.4,
	},
	"wood sword": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/woodsword.PNG",
		"scale": 0.05,
		"toolType": "damaging",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 2,
		"cooldown": 2.5
	},
	"stone sword": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/stonesword.PNG",
		"scale": 0.05,
		"toolType": "damaging",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 5,
		"cooldown": 1.9,
	},
	"iron sword": {
		"points" : 75,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/Iron_sword.PNG",
		"scale": 0.05,
		"toolType": "damaging",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 20,
		"cooldown": 1.75,
	},
	"wood axe": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/woodaxe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 1,
		"dmg": 1,
		"dmgMultiplier": 4,
		"cooldown": 2
	},
	"stone axe": {
		"points" : 40,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/stoneaxe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 2,
		"dmg": 2,
		"dmgMultiplier": 5,
		"cooldown": 2
	},
	"iron axe": {
		"points" : 80,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/tools/Iron_axe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 3,
		"dmg": 5,
		"dmgMultiplier": 5,
		"cooldown": 1.5
	},
	"campfire": {
		"points" : 15,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/builds/campfire.PNG",
		"scale": 0.05,
	},
	"smelter": {
		"points" : 20,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/builds/furnaceon.PNG",
		"scale": 0.05,
	},
	"crafting table": {
		"points" : 15,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/builds/crafter.PNG",
		"scale": 0.05,
	},
	"apple": {
		"points": 10,
		"type": "food",
		"scale": 0.05,
		"png": "res://drawn assets/food/apple.PNG",
		"stackable": true,
		"foodScore": 15,
		"heal": 5,
	},
	"cherry": {
		"points": 10,
		"type": "food",
		"scale": 0.05,
		"png": "res://drawn assets/food/cherry.PNG",
		"stackable": true,
		"foodScore": 10,
		"heal": 8,
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
	}
}

var cratables = {
	"wood sword": {
		"items": {
			"sticks": 12,
		},
		"amount": 1,
		"time": 8,
	},
	"stone sword": {
		"builds": ["crafting table"],
		"items": {
			"sticks": 4,
			"rocks": 12,
		},
		"amount": 1,
		"time": 8,
	},
	"iron sword": {
		"builds": ["crafting table"],
		"items": {
			"sticks": 4,
			"smelted iron": 3,
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
			"sticks": 4,
			"rocks": 3,
		},
		"amount": 1,
		"time": 3,
	},
	"iron axe": {
		"builds": ["crafting table"],
		"items": {
			"sticks": 4,
			"smelted iron": 3,
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
			"sticks": 4,
			"rocks": 8,
		},
		"amount": 1,
		"time": 3,
	},
	"iron pickaxe": {
		"builds": ["crafting table"],
		"items": {
			"sticks": 4,
			"smelted iron": 3,
		},
		"amount": 1,
		"time": 5,
	},
	"campfire": {
		"items": {
			"logs": 3,
			"sticks": 3,
			"leafs": 5,
		},
		"amount": 1,
		"time": 5,
	},
	"crafting table": {
		"items": {
			"sticks": 25,
			"rocks": 3,
		},
		"amount": 1,
		"time": 8,
	},
	"smelter": {
		"items": {
			"rocks": 15,
		},
		"amount": 1,
		"time": 8,
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
			"iron ore": 3,
		},
		"amount": 1,
		"time": 5,
	},
}

var placeables = {
	"campfire": {
		"scale": 0.12,
		"lifetime": 60,
		"warmth": 15,
		"range": 125,
	},
	"smelter": {
		"scale": 0.15,
		"lifetime": 999999,
		"warmth": 8,
		"range": 100,
	},
	"crafting table": {
		"scale": 0.15,
		"lifetime": 9999999,
		"range": 10,
	},
}

var resourceNodes = {
	"tree": {
		"png": "res://drawn assets/nature&rock/tree.PNG",
		"scale": 1,
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
				"chance": 80,
				"minAmount": 2,
				"maxAmount": 4,
			},
		},
		"hp": 5,
		"dropTimes": 5,
		"toolMult": "axe",
		"damageTier": 0,
	},
	"apple tree": {
		"png": "res://drawn assets/nature&rock/tree apple.PNG",
		"scale": 1,
		"multiDrop": true,
		"drops": {
			"apple": {
				"chance": 15,
				"minAmount": 2,
				"maxAmount": 3,
			},
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
				"chance": 80,
				"minAmount": 2,
				"maxAmount": 4,
			},
		},
		"hp": 50,
		"dropTimes": 10,
		"toolMult": "axe",
		"damageTier": 1,
	},
	"gold tree": {
		"png": "res://drawn assets/nature&rock/three gold.PNG",
		"scale": 1,
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
		"hp": 150,
		"dropTimes": 7,
		"toolMult": "axe",
		"damageTier": 2,
	},
	"bush": {
		"png": "res://drawn assets/nature&rock/bush.PNG",
		"scale": 1,
		"multiDrop": false,
		"drops": {
			"sticks": {
				"chance": 50,
				"minAmount": 3,
				"maxAmount": 4,
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
				"chance": 30,
				"minAmount": 1,
				"maxAmount": 3,
			},
			"sticks": {
				"chance": 60,
				"minAmount": 1,
				"maxAmount": 1,
			},
			"leafs": {
				"chance": 80,
				"minAmount": 1,
				"maxAmount": 1,
			},
		},
		"hp": 10,
		"dropTimes": 10,
		"toolMult": "",
		"damageTier": 0,
	},
	"rock": {
		"png": "res://drawn assets/nature&rock/rock_formation.PNG",
		"scale": 1,
		"multiDrop": false,
		"drops": {
			#"iron": {
			#	"chance": 20,
			#	"minAmount": 1,
			#	"maxAmount": 3,
			#},
			"rocks": {
				"chance": 80,
				"minAmount": 2,
				"maxAmount": 3,
			},
		},
		"hp": 25,
		"dropTimes": 5,
		"toolMult": "pickaxe",
		"damageTier": 1,
	},
	"iron rock": {
		"png": "res://drawn assets/nature&rock/iron recource.PNG",
		"scale": 1,
		"multiDrop": true,
		"drops": {
			"iron": {
				"chance": 20,
				"minAmount": 1,
				"maxAmount": 3,
			},
			"rocks": {
				"chance": 100,
				"minAmount": 1,
				"maxAmount": 2,
			},
		},
		"hp": 50,
		"dropTimes": 3,
		"toolMult": "pickaxe",
		"damageTier": 2,
	}
}
