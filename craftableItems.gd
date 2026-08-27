extends Node

var items = {
	"fists": {
		"png": "",
		"type": "tool",
		"toolType": "",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 1
	},
	"logs": {
		"points" : 3,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/log.PNG",
		"scale": 0.08,
	},
	"sticks": {
		"points" : 2,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/stick.PNG",
		"scale": 0.08,
	},
	"rocks": {
		"points" : 2,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/rockOre.PNG",
		"scale": 0.08,
	},
	"leafs": {
		"points" : 1,
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/leaf.PNG",
		"scale": 0.08,
	},
	"pickaxe": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/Iron_Picaxe.PNG",
		"scale": 0.05,
		"toolType": "pickaxe",
		"tier": 1,
		"dmg": 2,
		"dmgMultiplier": 3
	},
	"sword": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/Iron_sword.PNG",
		"scale": 0.05,
		"toolType": "sword",
		"tier": 0,
		"dmg": 1,
		"dmgMultiplier": 5
	},
	"axe": {
		"points" : 26,
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/Iron_axe.PNG",
		"scale": 0.05,
		"toolType": "axe",
		"tier": 1,
		"dmg": 1,
		"dmgMultiplier": 4
	},
	"campfire": {
		"points" : 15,
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/log.PNG",
		"scale": 0.08,
	}
}

var cratables = {
	"sword": {
		"items": {
			"sticks": 4,
			"rocks": 5
		},
		"amount": 1,
		"time": 8,
	},
	"axe": {
		"items": {
			"sticks": 5
		},
		"amount": 1,
		"time": 3,
	},
	"pickaxe": {
		"items": {
			"sticks": 10,
			"logs": 3,
		},
		"builds": ["workbench"],
		"amount": 1,
		"time": 3,
	},
	"campfire": {
		"items": {
			"logs": 3,
			"sticks": 3,
			"leafs": 5,
		},
		"amount": 1,
		"time": 5,
	}
}

var placeables = {
	"campfire": {
		"scale": 0.15,
		"lifetime": 60,
		"warmth": 10,
		"range": 100,
	}
}

var resourceNodes = {
	"tree": {
		"png": "res://drawn assets/tree.PNG",
		"scale": 0.08,
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
	"rock": {
		"png": "res://drawn assets/rockFormation.PNG",
		"scale": 0.08,
		"multiDrop": false,
		"drops": {
			"iron": {
				"chance": 20,
				"minAmount": 1,
				"maxAmount": 3,
			},
			"rocks": {
				"chance": 100,
				"minAmount": 2,
				"maxAmount": 3,
			},
		},
		"hp": 25,
		"dropTimes": 5,
		"toolMult": "pickaxe",
		"damageTier": 1,
	}
}
