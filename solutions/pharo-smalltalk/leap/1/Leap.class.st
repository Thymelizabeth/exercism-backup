Class {
	#name : #Leap,
	#superclass : #Object,
	#category : #'Exercise@Leap'
}

{ #category : #utilities }
Leap >> leapYear: year [
	^(year % 400 = 0) | ((year % 100 ~= 0) & (year % 4 = 0))
]
