//: Playground - noun: a place where people can play

import UIKit

var someNames = ["Fred", "Casper", "Bob", "Jim"]

func reverseArray(var array: [AnyObject]) -> [AnyObject] {
    
    var newArray = [AnyObject]()
    
    for items in array {
        newArray.append(array.removeLast())
    }
    
    return newArray
    
}


reverseArray(someNames)


