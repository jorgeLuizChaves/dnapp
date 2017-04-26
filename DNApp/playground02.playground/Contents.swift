//: Playground - noun: a place where people can play

import UIKit

//CGRectMake, CGPointMake, CGSizeMake removed from Swift 3, use instead CGRect, CGPoint, CGSize
let canvas = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
canvas.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 0.8)

let title = UILabel(frame: CGRect(x: 0, y: 70, width: 200, height: 50))
title.backgroundColor = UIColor.blue
title.textColor = UIColor.white
title.text = "Learning Swift"
//you can omit the enum like so .center
title.textAlignment = NSTextAlignment.center
title.font = UIFont(name: "Avenir Next", size: 20)

canvas.addSubview(title)

//constant and variable

let name = "Jonh"
var age = 30

//Value Types
let label = "the value is "
let value = 100
let result = label + String(value)

//Arrays
var numbers = [3, 4, 5, 6]
numbers.append(9)

//remove
numbers.remove(at: 0)


//Control Flow

if age > 30 {
    print("You are getting old.")
}else {
    print("You are so young")
}

switch age {
case 0...10:
    print("You are a Kid")
case 11...20:
    print("You are a young")
case 20...50:
    print("You are an Adult")
default:
    print("I don't know what to say")
}

//loop

for number in numbers {
    print(number)
}




