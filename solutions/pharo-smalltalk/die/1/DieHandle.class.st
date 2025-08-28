"
I am a `DieHandle`. I hold any number of `Die`s, allowing them to be rolled at once.

Public API and Key Messages

- `diceNumber` - The number of `Die`s I am currently holding
- `addDie:` - Add another `Die` to hold
- I can be created using the `d20` or `d10` extension methods on `Integer`.

Internal Representation and Key Implementation Points.

    Instance Variables
	dice:		The `Die`s I am currently holding

"
Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'Exercise@Die'
}

{ #category : #adding }
DieHandle >> + other [
	self dice addAll: other dice.
]

{ #category : #adding }
DieHandle >> addDie: die [
	dice add:  die.
]

{ #category : #accessing }
DieHandle >> dice [
	^dice
]

{ #category : #accessing }
DieHandle >> diceNumber [
	^dice size
]

{ #category : #initialization }
DieHandle >> initialize [
	super initialize.
	dice := LinkedList new
]

{ #category : #action }
DieHandle >> roll [
	^(dice collect: [ :value | value roll ]) sum
]
