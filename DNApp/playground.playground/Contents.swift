//: Playground - noun: a place where people can play

import UIKit
import SwiftyJSON

var str = "Hello, playground"

// creating a variable
var number = 4
var number2 = 3

print(number + number2)

// constant
let name = "Jonh"

/*
 It's not necessary to declare the variable type, but you can do that
 */

let surName: String = "Connor"

//Arrays

var colors = ["red", "blue", "green"]

//add in an Array

colors.append("yellow")


//remove 

colors.remove(at: 0)

print(colors)

//for loop

for color in colors {
    print(color)
}

//functions

func pointsToRetina(point: Int) -> Int {
    return point * 2
}

pointsToRetina(point: 3)


//Class and Struct

//Struct has a default Initializer, Struct is a value type
//https://developer.apple.com/swift/blog/?id=10
struct UserStruct {
    var name: String
    var age: Int
    var job: String
}

var user = UserStruct(name: "Jorge", age: 30, job: "Consultant")

user.name

//Class its necessary to declare a init function and its a reference type
//https://developer.apple.com/swift/blog/?id=10

class User{
    var name:String
    
    init(name: String) {
        self.name = name
    }
}

var jonh = User.init(name: "Jonh")

print(jonh.name)


//Optionals

var numberX:Int? = 0


var testeStringReplace = "Brasil\n".replacingOccurrences(of: "\n", with: "")


let storyUpvotes = [9, 11,1,2,3,4,5]
let userUpvotes = [ 8, 90, 75, 119]

let setStory = Set(storyUpvotes.sorted())
let setUser = Set(userUpvotes.sorted())



let resultSet = setStory.intersection(setUser)
resultSet.count

let jsonA = JSON([JSON(123),JSON(123)])

let convertA = jsonA.rawValue





var list: [Int] = [1,2,3]



list.append(4)


















