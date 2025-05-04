extends Node
var Ballora = false
var Bonnie = false
var Chica = false
var Foxy = false
var Golden_plush = false
var GameScene = 1

var scene = ""

func SetScene(NewScene):
	scene = NewScene
	
var coins_collected = 0
var required_coins = 1
func ResetCoinsCollected():
	coins_collected = 0
func AddRequiredCoins():
	required_coins+=1
func NextGameScene():
	GameScene +=1
func ResetGameScene():
	GameScene = 1
