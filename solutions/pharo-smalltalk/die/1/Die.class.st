"
I am a die with a certain number of faces, able to be rolled.

I work with a `DieHandle`, allowing multiple `Die`s to be rolled together.

Public API and Key Messages

- `faces` and `faces:` - getter and setter for my `faces` variable
- `roll` to get a random number between 1 and `faces`
- Use `withFaces: faces` to create an instance of me with `faces` faces


Internal Representation:

    Instance Variables
	faces:		Integer - The number of faces I have
"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'Exercise@Die'
}

{ #category : #construction }
Die class >> withFaces: _faces [

	^ self new faces: _faces
]

{ #category : #accessing }
Die >> faces [ 
	^faces
]

{ #category : #construction }
Die >> faces: _faces [ 
	faces := _faces.
]

{ #category : #initialization }
Die >> initialize [
	super initialize.
	faces := 6.
]

{ #category : #action }
Die >> roll [
	^faces atRandom
]
