Class {
	#name : #ResistorColorDuo,
	#superclass : #Object,
	#instVars : [
		'lookupTable'
	],
	#category : #'Exercise@ResistorColorDuo'
}

{ #category : #initialization }
ResistorColorDuo >> initialize [ 
	lookupTable := Dictionary newFromKeys: {'black' . 'brown' . 'red' . 'orange' . 'yellow' . 'green' . 'blue' . 'violet' . 'grey' . 'white'} andValues: (0 to: 9)
]

{ #category : #utilities }
ResistorColorDuo >> valueWithColors: colours [
	^((colours takeFirst: 2) collectWithIndex: [ :each :index | (lookupTable at: each ifAbsent: [ KeyNotFound signalFor: 'Invalid color: ' , each]) * (10 raisedToInteger: (colours size min: 2) - index) ]) sum
]
