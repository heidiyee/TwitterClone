//: Playground - noun: a place where people can play

import UIKit

var newArray = [Int]()
var mixedArray = [AnyObject]()
var i: Int

for (i = 0; i < 100; i++) {
    newArray.append(i + 1)
}



print(newArray)

for (i = 0; i < 100; i++) {
    var number = newArray[i]
    if number % 3 == 0 {
        if  number % 5 == 0 {
            mixedArray.append("FIZZBUZZ")
        }
        mixedArray.append("FIZZ")
    }
    else if number % 5 == 0 {
        mixedArray.append("BUZZ")
    }
    else {
    mixedArray.append(newArray[i])
    }
    
}


print(mixedArray)
