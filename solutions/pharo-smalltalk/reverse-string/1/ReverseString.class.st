Class {
	#name : #ReverseString,
	#superclass : #Object,
	#category : #'Exercise@ReverseString'
}

{ #category : #action }
ReverseString >> reverseValue: string [
	|stack result|
	stack := Stack new.
	string do: [ :each | stack push: each ].
	result := String new writeStream.
	stack do: [ :each | each putOn: result ].
	^result contents
]
