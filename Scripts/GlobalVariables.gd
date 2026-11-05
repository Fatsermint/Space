extends Node


var bulletDamages = [20]
var whitelistedObjectsNames = ["bullets", "Camera", "Label", "asteroid", "Settings", "UI", "BG", "Phone_Buttons"]	
var playerInfo = {
	"level": 2,
	"bullet": "level1",
	"failed": null,
	"coins": 0,
	"device": null,
	"hp": 200,
	"stats":{
		"fired":0,
		"enemydestroyed":0
	},
	"effects":{
		
	}
}

var cages = {
	"loot":{
		"coins50": {
			"path":"res://Assets/coins50.svg",
			"effect": {
				"giveCoins": 50,
				"positive": true,
				"time": null
			}
		},
		"coinsx2": {
			"path":"res://Assets/coinx2.svg",
			"effect": {
				"coinEffect":2,
				"positive": true,
				"time": 10,
				
			},
		},
		"reverse":{
			"path": "res://Assets/reverse.svg",
			"effect":{
				"changeControls" : "reverse",
				"positive": false,
				"time": 10
			}
		} ,
		"freeze":{
			"path": "res://Assets/freeze.svg",
			"effect":{
				"freeze" : 0,
				"positive": true,
				"time": 3
			}
		} 
	}
}

var shop = {
	"bullets":{
		"normal":{
			"damage":20,
			"effects":{
				
			}
		},
		"plasma":{
			"damage":35,
			"effects":{
				"slow":{
					"time": 1,
					"strenght":0.75,
				}
			}
		},
	}
}




var enemyInfo = {
	"enemy1": {
		"path": "res://Scenes/basic.tscn",
		"shield": {
			"%":1,
			"normal":0
		},
		"speed":1,
		"value": 10,
		"child":null
	},
	"enemy2":{
		"path": "res://Scenes/enemy_2.tscn",
		"shield":{
			"%":0.5,
			"normal":5
		},
		"speed": 0.5,
		"value": 40,
		"child":null
	},
	"enemy3":{
		"path": "res://Scenes/enemy_3.tscn",
		"shield":{
			"%": 0.75,
			"normal":0
		},
		"speed": 1.5,
		"value": 75,
		"child":{
			"positions":[[75, 0],[-75, 0]],
			"type": "enemy1",
			"hp": 100,
			"status": "alive"
		}
	}
}


var levels = {
	1:{
		"player":[[0, -25], true],
		"enemy1":[
			[[0, -1000], 100],
		],
		"settings":true,
		"cages": true
	},
	2:{
		"player":[[0, -25], true],
		"enemy1":[
			[[0, -1100], 100]
			,
			[[0, -1300], 100]
			],
		"settings":true,
		"cages": true
		
			
	},
	3:{
		"player":[[0, -25], true],
		"enemy1":[
			[[0, -1000], 100]
			,
			[[-100, -1400], 100]
			,
			[[100, -1400], 100]
			],
		"settings":true,
		"cages": true
		
			
	},
	4:{
		"player":[[0, -25], true],
		"enemy1":[
			[[-100, -1000], 100]
			,
			[[100, -1000], 100]
			,
			[[0, -1300], 100]
			,
			[[200, -1600], 100]
			],
		"settings":true,
		"cages": true
		
			
	},
	5:{
		"player":[[0, -25], true],
		"enemy1":[
			[[75, -1000], 100]
			,
			[[-75, -1000], 100]
			,
			[[100, -1300], 100]
			,
			[[-100, -1600], 100]
			,
			[[100, -1600], 100]
			],
		"cages": true,
		"settings":true,
			
	},
	6:{
		"player":[[0, -25], true],
		"enemy2":[[[0, -1000], 100]],
		"settings":true,
		"cages": true,
			
	},
	7:{
		"player":[[0, -25], true],
		"enemy1":[
			[[75, -1000], 100]
			,
			[[-75, -1000], 100]
			],
		"enemy2":[
			[[0, -1300], 100]
		],
		"cages": true,
		"settings":true
			
	},
	8:{
		"player":[[0, -25], true],
		"enemy1":[
			[[75, -1000], 100]
			,
			[[-75, -1000], 100]
			,
			[[0, -1100], 100]
			,
			[[100, -1300], 100]
			,
			[[-100, -1300], 100]
			,
			[[0, -1300], 100]
			,
			[[-100, -1600], 100]
			,
			[[100, -1600], 100]
			
			],
		"cages": true,
		"settings":true
			
	},
	9:{
		"player":[[0, -25], true],
		"enemy1":[
			[[75, -1000], 100]
			,
			[[0, -1000], 100]
			,
			[[-75, -1000], 100]
			],
		"enemy2":[
			[[0, -1300], 100]
		],
		"cages": true,
		"settings":true
			
	},
	10:{
		"player":[[0, -25], true],
		"enemy1":[
			[[75, -1300], 100]
			,
			[[0, -1300], 100]
			,
			[[-75, -1300], 100]
			],
		"enemy2":[
			[[0, -1000], 100]
		],
		"cages": true,
		"settings":true
			
	},
	11:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[75, -1000], 75],
			[[-75, -1300], 75]
		],
		"cages": true,
		"settings":true
			
	},
	12:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[75, -1000], 75],
			[[-75, -1000], 75]
		],
		"enemy1":[
			[[75, -1250], 100],
			[[-75, -1250], 100]
			
		],
		"cages": true,
		"settings":true
			
	},
	13:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[100, -1250], 100],
			[[-100, -1250], 100]
		],
		"enemy1":[
			[[0, -1000], 100],
			[[75, -1050], 100],
			[[-75, -1050], 100],
			[[0, -1100], 100],
			[[-75, -1300], 100],
			[[-75, -1300], 100],
			
		],
		"cages": true,
		"settings":true
			
	},
	14:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[100, -1100], 75],
			[[0, -1100], 75],
			[[-100, -1100], 75]
		],
		"enemy1":[
			[[0, -1000], 100],
			[[0, -1250], 100],
		],
		"settings":true,
		"cages": true,
			
	},
	15:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[100, -1100], 100],
			[[0, -1200], 100],
			[[-100, -1100], 100]
		],
		"enemy1":[
			[[0, -1250], 100],
		],
		"cages": true,
		"settings":true,
			
	},
	16:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[0, -1150], 100],
			[[0, -1450], 100],
		],
		"enemy1":[
			[[75, -1050], 100],
			[[-75, -1050], 100],
			[[75, -1350], 100],
			[[-75, -1350], 100],
			
		],
		"cages": true,
		"settings":true
			
	},
	17:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[75, -1150], 100],
			[[-75, -1150], 100],
			[[75, -1450], 100],
			[[-75, -1450], 100],
		],
		"enemy1":[
			[[0, -1050], 100],
			[[0, -1350], 100],
			
		],
		"cages": true,
		"settings":true
			
	},
	18:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[75, -1050], 100],
			[[-75, -1050], 100],
			[[75, -1350], 100],
			[[-75, -1350], 100],
		],
		"enemy1":[
			[[0, -1050], 100],
			[[0, -1350], 100],
			
		],
		"cages": true,
		"settings":true
			
	},
	19:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[0, -1300], 100],
			[[75, -1400], 100],
			[[-75, -1400], 100],
		],
		"enemy1":[
			[[0, -1000], 100],
			[[50, -1075], 100],
			[[-50, -1075], 100],
			[[100, -1150], 100],
			[[-100, -1150], 100],
			[[150, -1225], 100],
			[[-150, -1225], 100],
		],
		"cages": true,
		"settings":true
			
	},
	20:{
		"player":[[0, -25], true],
		
		"enemy2":[
			[[0, -1300], 100],
			[[75, -1400], 100],
			[[-75, -1400], 100],
			[[0, -1400], 100],
			[[0, -1500], 100],
			[[75, -1550], 100],
			[[-75, -1550], 100],
			
			
			
		],
		"enemy1":[
			[[0, -1000], 100],
			[[50, -1075], 100],
			[[-50, -1075], 100],
			[[100, -1150], 100],
			[[-100, -1150], 100],
			[[150, -1225], 100],
			[[-150, -1225], 100],
			[[200, -1300], 100],
			[[-200, -1300], 100],
		],
		"cages": true,
		"settings":true
			
	},
	21:{
		"player":[[0, -25], true],
		"enemy2":[
			[[0, -1300], 100],
			[[75, -1400], 100],
			[[-75, -1400], 100],
			[[0, -1400], 100],
			[[0, -1500], 100],
			[[75, -1550], 100],
			[[-75, -1550], 100],
			
			
			
		],
		"enemy1":[
			[[0, -1000], 100],
			[[50, -1075], 100],
			[[-50, -1075], 100],
			[[100, -1150], 100],
			[[-100, -1150], 100],
			[[150, -1225], 100],
			[[-150, -1225], 100],
			[[200, -1300], 100],
			[[-200, -1300], 100],
		],
		"enemy3":[
			[[0, -1650], 100],
			[[0, -1800], 100]
		],
		"cages": true,
		"settings":true
			
	},
	22:{
		"player":[[0, -25], true],
		"enemy2":[
			[[0, -1300], 100],
			[[75, -1400], 100],
			[[-75, -1400], 100],
			[[0, -1400], 100],
			[[0, -1500], 100],
			[[75, -1550], 100],
			[[-75, -1550], 100],
			
			
			
		],
		
		"enemy3":[
			[[0, -1650], 100],
			[[0, -1000], 100],
			[[-100, -1200], 100],
			[[100, -1200], 100],
			[[0, -1800], 100],
			[[0, -1700], 100]
			
		],
		"cages": true,
		"settings":true
			
	},
}
