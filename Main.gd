extends Node2D

var Guy=load('res://Follower.tscn')

var Task1=randomize()
var Task2=randomize()
var Task3=randomize()

var CurrentTasks

var TextTask

func BankRob(ChancePercent, Logic):
	var Chance=randi()%99

	if Chance<=ChancePercent and $EventNode/GangsterPath.get_child_count()==0 and $EventNode/PolicePath.get_child_count()==0:

		var BanditCar=Global.Car.instance()
		BanditCar.get_node('Car').set_animation('BanditCar')
		BanditCar.Speed=290
		BanditCar.get_node('Car').get_node('CarArea').Type='BanditCar'
		$EventNode/GangsterPath.add_child(BanditCar)

		yield(get_tree().create_timer(3.3), "timeout")

		BanditCar.set_process(false)

		var Gansters=Guy.instance()
		Gansters.get_node('Guy').set_animation('BanditsStay')
		$GangsterPosition.add_child(Gansters)

		var PoliceCar=Global.Car.instance()
		PoliceCar.Speed=270
		PoliceCar.get_node('Car').set_animation('PoliceCar')
		$EventNode/PolicePath.add_child(PoliceCar)
		
		yield(get_tree().create_timer(2), "timeout")

		PoliceCar.set_process(false)

		var Police=Guy.instance()
		Police.get_node('Guy').set_animation('PoliceStay')
		Police.get_node('Guy').flip_h=true
		$PolicePosition.add_child(Police)

		yield(get_tree().create_timer(2), "timeout")

		Police.get_node('Guy').set_animation('PoliceShoot')
		Gansters.get_node('Guy').set_animation('BanditsShoot')

		yield(get_tree().create_timer(3), "timeout")

		Police.queue_free()
		Gansters.queue_free()
		PoliceCar.set_process(true)
		BanditCar.set_process(true)

		yield(get_tree().create_timer(5.1), "timeout")
		PoliceCar.queue_free()
		BanditCar.queue_free()

		Logic=false

func CarAppear(ChancePercent):
	var Chance=randi()%99

	if Chance<=ChancePercent:
		
		var Car=Global.Car.instance()
		$CarPathNode.get_node(Global.PathCarArray[randi()%Global.PathCarArray.size()]).add_child(Car)
		
		var CarType=Global.CarArray[randi()%Global.CarArray.size()]
		Car.get_node('Car').get_node('CarArea').Type=CarType
		Car.get_node('Car').set_animation(CarType)
	
		yield(get_tree().create_timer(12), "timeout")
		
		Car.queue_free()

func Suic(ChancePercent, Logic):
	var PathSuic=$EventNode.get_node(Global.SuicidePath[randi()%4])
	var Chance=randi()%99

	if Chance<=ChancePercent and PathSuic.get_child_count()==0:

		var suic=Guy.instance()
		suic.get_node('Guy').get_node('GuyArea').Type='Suicide'
		suic.loop=false
		
		
		suic.set_offset(0)
		PathSuic.add_child(suic)

		suic.set_process(true)
		suic.get_node('Guy').set_animation('SuicFall')
		
		yield(get_tree().create_timer(.85), "timeout")

		suic.set_process(false)
		suic.get_node('Guy').set_animation('SuicGetUp')

		yield(get_tree().create_timer(1.5), "timeout")

		suic.set_process(true)
		suic.get_node('Guy').set_animation('SuicWalk')

		yield(get_tree().create_timer(1.5), "timeout")

		suic.queue_free()

	Logic=false

func Superman(ChancePercent, guy, Logic):
	
	var Chance=randi()%99

	if Chance<=ChancePercent and $EventNode/SuperPath.get_child_count()==0:
		
		var super=Guy.instance()
		super.get_node('Guy').get_node('GuyArea').Type='Super'
		$EventNode/SuperPath.add_child(super)
		super.set_process(false)
		$EventNode/SuperPath.position=guy.get_parent().position
		super.get_node('Guy').set_animation('SuperReady')

		yield(get_tree().create_timer(2), "timeout")

		super.get_node('Guy').set_animation('SuperStay')

		yield(get_tree().create_timer(1.5), "timeout")

		super.rotate=true
		super.set_process(true)
		super.Speed=320
		super.get_node('Guy').set_animation('SuperFly')

		super.get_parent().set_process(true)

		yield(get_tree().create_timer(5), "timeout")
		super.queue_free()

	Logic=false

func GuyTransformer(ChancePercent, guy, StayAnimation, WalkAnimation, AppearTimer, IsWalk, Logic, Type):

	guy.get_parent().set_process(false)
	
	var Chance=randi()%99

	if Chance<=ChancePercent:
		guy.set_animation(StayAnimation)
		guy.get_node('GuyArea').Type=Type

		yield(get_tree().create_timer(2), "timeout")

		guy.set_animation(WalkAnimation)
		guy.get_parent().set_process(IsWalk)

		yield(get_tree().create_timer(AppearTimer), "timeout")
	
		guy.set_animation('GuyWalk')
		guy.get_node('GuyArea').Type='Guy'
		guy.get_parent().set_process(true)
		Logic=false

func _ready():
	Global.Points=0

	Task1=Global.Task[randi()%7]
	Task2=Global.Task[randi()%7]
	Task3=Global.Task[randi()%7]
	
	CurrentTasks={
	'First': Task1,
	'Second': Task2,
	'Third': Task3,
	}
	
	TextTask={
		'First': Global.TaskArray[CurrentTasks['First']],
		'Second': Global.TaskArray[CurrentTasks['Second']],
		'Third': Global.TaskArray[CurrentTasks['Third']],
	}
	
	$UINode/Tasks/Task1.text=TextTask['First']
	$UINode/Tasks/Task2.text=TextTask['Second']
	$UINode/Tasks/Task3.text=TextTask['Third']
		
	
	var GuyCount=0
	var CarCount=0

	while GuyCount<55:
		var GuyInst=Guy.instance()
		GuyInst.get_node('Guy').connect("Change", $".", 'Stoper')

		$PathNode.get_node(Global.PathArray[randi()%Global.PathArray.size()]).add_child(GuyInst)

		GuyCount+=1
	
	while CarCount<25:
		var CarInst=Global.Car.instance()
		CarInst.connect("ChangeCar", $".", 'CarChanger')

		$CarPathNode.get_node(Global.PathCarArray[randi()%Global.PathCarArray.size()]).add_child(CarInst)
		CarCount+=1

func Stoper(guy):
	var Chance=randi()%99
	
	if Chance<=20:
		guy.set_animation('GuyStay')
		guy.get_parent().set_process(false)

		yield(get_tree().create_timer(3), "timeout")

		var Logic=true
		while Logic:
			GuyTransformer(7, guy, 'ClownStay', 'ClownWalk', 7, true, Logic, 'Clown')
			GuyTransformer(10, guy, 'MusicianStay', 'MusicianPlay', 5, false, Logic, 'Musician')
			GuyTransformer(10, guy, 'LadyStay', 'LadyWalk', 9, true, Logic, 'Lady')
			Superman(7, guy, Logic)
			Suic(10, Logic)
			BankRob(5, Logic)

			Logic=false

func CarChanger():
	CarAppear(5)

func _on_RoundTimer_timeout():
	get_tree().change_scene("res://End.tscn") 

var IsShoot=false

func _on_FirstArea_area_entered(area):
	if area.Type=='Guy' and IsShoot==false:

		IsShoot=true

		$Camera/ShootBar.set_process(true)

		$Camera/ShootBar/ShootTimer.start(3)
		$Camera/ShootBar.show()
	

func _on_FirstArea_area_exited(area):
	if area.Type=='Clown':
		$Camera/ShootBar/ShootTimer.stop()
		$Camera/ShootBar.hide()
		IsShoot=false
	
