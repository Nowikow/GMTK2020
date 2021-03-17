extends Node2D

var Car=preload("res://FolowerCar.tscn")

var PathArray=['Path1', 'Path2', 'Path3', 'Path4', 'Path5', 'Path6', 'Path7', 'Path8', 'Path9', 'Path10']

var PathCarArray=['Path1', 'Path2', 'Path3', 'Path4']
var CarArray=['TaxiCar', 'PoliceCar', 'AmbCar', ]

var SuicidePath=['SuicidePath1', 'SuicidePath2', 'SuicidePath3', 'SuicidePath4']

var TaskArray={
	'Clown': 'Shoot  a  clown',
	'Lady': 'Shoot a lady',
	'Musician': 'Shoot a musician',
	'Suicide': 'Shoot an office worker',
	'Super': 'Shoot a superhero',
	'TaxiCar': 'Shoot a taxi',
	'BanditCar': 'Shoot a bank robbery ',
	'AmbCar': 'Shoot an ambulance'
}

var Task=['Clown', 'Lady', 'Musician', 'Suicide', 'Super', 'TaxiCar', 'BanditCar', 'AmbCar']

var Points=0

