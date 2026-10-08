extends Node


var bulletDamages = [20]
var whitelistedObjectsNames = ["bullets", "Camera", "Label"]
var playerInfo = {
	"level": 1
}

var levels = {
	1:{
		"player":[[0, -25], true],
		"basic":[
			[[100, -1000], 67]
			],
		"settings":true
	},
	2:{
		"player":[[0, -25], true],
		"basic":[
			[[100, -1100], 100]
			,
			[[-100, -1100], 100]
			],
		"settings":true
			
	},
	3:{
		"player":[[0, -25], true],
		"basic":[
			[[100, -1500], 100]
			,
			[[-100, -1500], 100]
			,
			[[-100, -1100], 100]
			],
		"settings":true
			
	},
}
