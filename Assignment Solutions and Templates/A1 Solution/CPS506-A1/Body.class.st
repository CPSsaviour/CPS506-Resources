"
I represent a body in the orbital system.
"
Class {
	#name : #Body,
	#superclass : #Object,
	#instVars : [
		'named',
		'distance',
		'orbits'
	],
	#category : #'CPS506-A1'
}

{ #category : #calculating }
Body >> distance: anInteger orbiting: aBody [

	self = aBody ifTrue: [ ^ anInteger ].
	orbits ifNil: [ ^ nil ].
	^ orbits distance: anInteger + distance orbiting: aBody
]

{ #category : #calculating }
Body >> distanceOrbiting: aBody [ 
	^ self distance: 0 orbiting: aBody
]

{ #category : #initialization }
Body >> initialize [
	super initialize.
	distance := 0
]

{ #category : #accessing }
Body >> name [
	^ named
]

{ #category : #accessing }
Body >> named: aString [ 
	named := aString
]

{ #category : #accessing }
Body >> orbitingCommon: aBody [

	| bodies |
	bodies := self orbits asSet.
	^ aBody orbits detect: [ :each | 
		(bodies includes: each) ] ifNone: [ nil ]
]

{ #category : #calculating }
Body >> orbitingOf: aCollection [
	aCollection add: self.
	orbits ifNil: [ ^ aCollection ].
	^ orbits orbitingOf: aCollection
]

{ #category : #accessing }
Body >> orbits [

	^ self orbitingOf: OrderedCollection new
]

{ #category : #initializing }
Body >> orbits: aBody atDistance: anInteger [
	orbits := aBody.
	distance := anInteger
]
