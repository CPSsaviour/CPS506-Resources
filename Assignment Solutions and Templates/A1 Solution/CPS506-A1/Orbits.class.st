"
I am the main class for the Orbits assignment
"
Class {
	#name : #Orbits,
	#superclass : #Object,
	#instVars : [
		'bodies'
	],
	#category : #'CPS506-A1'
}

{ #category : #'instance creation' }
Orbits class >> from: aString [ 
	^ self new from: aString
]

{ #category : #loading }
Orbits >> addOrbit: strings [
	strings size = 3 ifTrue: [(self find: strings third) orbits: (self find: strings first) atDistance: strings second asNumber]
]

{ #category : #lookup }
Orbits >> distanceFrom: aString to: aString2 [

	| body1 body2 |
	body1 := self find: aString.
	body2 := self find: aString2.
	^ (body1 distanceOrbiting: body2) ifNil: [ 
		  (body2 distanceOrbiting: body1) ifNil: [ | common |
			common := body1 orbitingCommon: body2.
			  (body1 distanceOrbiting: common) + (body2 distanceOrbiting: common) ] ]
]

{ #category : #lookup }
Orbits >> find: aString [

	^ bodies at: aString asSymbol ifAbsentPut: [ Body new named: aString asSymbol ]
]

{ #category : #initialization }
Orbits >> from: aString [

	^ String streamContents: [ :stream | 
		  aString linesDo: [ :line | 
			  | strings |
			  strings := line substrings.
			  self addOrbit: strings.
			  strings size = 2 ifTrue: [ 
				  stream
					  nextPutAll: ('From {1} to {2} is {3}km' format: { 
									   strings first.
									   strings second.
									   (self distanceFrom: strings first to: strings second) });
					  cr ].
			  strings size = 1 ifTrue: [ 
				  stream
					  nextPutAll: strings first;
					  nextPutAll: ' orbits'.
				  (self find: strings first) orbits allButFirst do: [ :body | 
					  stream
						  nextPut: $ ;
						  nextPutAll: body name ].
				  stream cr ] ] ]
]

{ #category : #initialization }
Orbits >> initialize [
	super initialize.
	bodies := Dictionary new
]
