Class {
	#name : #Gigasecond,
	#superclass : #Object,
	#category : #'Exercise@Gigasecond'
}

{ #category : #action }
Gigasecond >> addMoment: moment [
	|time stream|
	time := (DateAndTime readFromString: moment) + (Duration seconds: 1000000000).
	stream := String new writeStream.
	time printYMDOn: stream.
	stream << 'T'.
	time printHMSOn: stream.
	^stream contents
	
]
