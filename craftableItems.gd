extends Node

var items = {
	"logs": {
		"stackable": true,
		"png": "res://drawn assets/log.PNG"
	},
	
	"sticks": {
		"stackable": true,
		"png": "res://drawn assets/stick.PNG",
	},
	
	"rocks": {
		"stackable": true,
		"png": "res://drawn assets/rockOre.PNG",
	},
	
	"leafs": {
		"stackable": true,
		"png": "res://drawn assets/leaf.PNG",
	},
	
	"pickaxe": {
		"stackable": false,
		"png": "res://drawn assets/picaxe.PNG",
	},
	
	"sword": {
		"stackable": false,
		"png": "res://drawn assets/sword.PNG"
	},
	
	"axe": {
		"stackable": false,
		"png": "res://drawn assets/axe.PNG",
	},
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
