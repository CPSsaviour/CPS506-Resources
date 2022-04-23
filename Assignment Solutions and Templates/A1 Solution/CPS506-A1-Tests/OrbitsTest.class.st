Class {
	#name : #OrbitsTest,
	#superclass : #TestCase,
	#instVars : [
		'orbits'
	],
	#category : #'CPS506-A1-Tests'
}

{ #category : #tests }
OrbitsTest class >> solarSystem [

	" Data from https://space-facts.com/ "

	^ 'Sun 57909227 Mercury
Sun 149598262 Earth
Earth 384400 Moon
Moon 1757 LROrbiter
Mars 9376 Phobos
Mars 23458 Deimos
Sun 227943824 Mars
Sun 778340821 Jupiter
Sun 1426666422 Saturn
Sun 2870658186 Uranus
Sun 4498396441 Neptune
'
]

{ #category : #running }
OrbitsTest >> setUp [

	super setUp.
	orbits := Orbits new
		          from: self solarSystem;
		          yourself
]

{ #category : #tests }
OrbitsTest >> solarSystem [
	^ self class solarSystem
]

{ #category : #tests }
OrbitsTest >> testOrbits [

	self assert: (orbits distanceFrom: #Sun to: #Sun) equals: 0.
	self assert: (orbits distanceFrom: #Earth to: #Earth) equals: 0.
	self assert: (orbits distanceFrom: #Earth to: #Sun) equals: 149598262.
	self assert: (orbits distanceFrom: #Sun to: #Earth) equals: 149598262.
	self
		assert: (orbits distanceFrom: #Earth to: #Mercury)
		equals: 57909227 + 149598262.
	self assert: (orbits distanceFrom: #Sun to: #Moon) equals: 149598262 + 384400.
	self
		assert: (orbits distanceFrom: #Mercury to: #Moon)
		equals: 57909227 + 149598262 + 384400.
	self
		assert: (orbits distanceFrom: #Deimos to: #Moon)
		equals: 227943824 + 23458 + 149598262 + 384400
]

{ #category : #tests }
OrbitsTest >> testString [

	self
		assert: (Orbits from: self solarSystem , 'Sun Moon
Deimos Moon
Deimos
Deimos Phobos
Moon
LROrbiter
Sun
')
		equals: 'From Sun to Moon is 149982662km
From Deimos to Moon is 377949944km
Deimos orbits Mars Sun
From Deimos to Phobos is 32834km
Moon orbits Earth Sun
LROrbiter orbits Moon Earth Sun
Sun orbits
'
]
