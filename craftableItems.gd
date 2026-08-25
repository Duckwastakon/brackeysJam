extends Node

var items = {
	"fists": {
		"type": "tool",
		"toolType": "",
		"dmg": 1,
		"dmgMultiplier": 1
	},
	"logs": {
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/log.PNG"
	},
	"sticks": {
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/stick.PNG",
	},
	"rocks": {
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/rockOre.PNG",
	},
	"leafs": {
		"type": "item",
		"stackable": true,
		"png": "res://drawn assets/leaf.PNG",
	},
	"pickaxe": {
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/picaxe.PNG",
	},
	"sword": {
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/sword.PNG"
	},
	"axe": {
		"type": "tool",
		"stackable": false,
		"png": "res://drawn assets/axe.PNG",
	},
	"campfire":{
		"type": "placeable",
		"stackable": false,
		"png": "res://drawn assets/axe.PNG",
	}
}

var cratables = {
	"sword": {
		"items": {
			"sticks": 3
		},
		"amount": 1,
		"time": 3,
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
			"sticks": 8
		},
		"amount": 1,
		"time": 3,
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
