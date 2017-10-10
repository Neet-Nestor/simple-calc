//
//  main.swift
//  SimpleCalc
//
//  Created by Nestor Qin on 10/5/17.
//  Copyright © 2017 Nestor Qin. All rights reserved.
//
// This is a simple command-line calculator, which supports simple calculations
// and some multi-operand operations like count, average and factorial

import Foundation

// returns if a String represents a number
func isNum(str:String) -> Bool {
    return str.range(of: "^-?[0-9]+([\\.][0-9]+)?$", options: .regularExpression) != nil
}

// returns if a String only contains a positive number
func isPositiveInt(str:String) -> Bool {
    return str.range(of: "^[0-9]+$", options: .regularExpression) != nil
}

print("Enter an expression separated by returns:")

var response = readLine(strippingNewline: true)!

if (response.lowercased().hasSuffix("count")) {  // operation "count": count the number of input
    let numbersArr = response.components(separatedBy: " ")
    var count:Int = 0;
    var wrong = false
    for i in 0...(numbersArr.count - 2) {
        let num = numbersArr[i]
        if (isNum(str: num)) {   // if this String is a number
            count += 1
        } else {
            print("Illegal input")
            wrong = true
            break
        }
    }
    if (!wrong) {
        print("result: \(count)")
    }
} else if (response.lowercased().hasSuffix("avg")) {    // operation "avg": average all the inputs
    let numbersArr = response.components(separatedBy: " ")
    var sum:Double = 0.0;
    var count = 0
    var wrong = false
    for i in 0...(numbersArr.count - 2) {
        let num = numbersArr[i]
        if (isNum(str: num)) {  // if this String is a number
            sum += Double(num)!
            count += 1
        } else {
            wrong = true
            print("Illegal input")
            break
        }
    }
    if (!wrong) {
        let result = sum / Double(count)
        print("result: \(result)")
    }
} else if (response.lowercased().hasSuffix("fact")) {   // operation "fact": calculate factorial
    let numbersArr = response.components(separatedBy: " ")
    if (numbersArr.count > 2 || !isPositiveInt(str: numbersArr[0])) {
        print("Error: Illegal input")
    } else {
        let num = numbersArr[0]
        var result:Int = 1;
        for i in 2...Int(num)! {
            result *= Int(i)
        }
        print("result: \(result)")
    }
} else {    // normal expression calculations (+,-,*,/)
    if (isNum(str: response)) {
        let num1:Double = Double(response)!
        let operation = readLine(strippingNewline: true)!
        switch operation {
        case "+", "-", "*", "/":
            response = readLine(strippingNewline: true)!
            if (isNum(str: response)) {
                let num2 = Double(response)!
                var result:Double = 0.0;
                switch operation {
                case "+":
                    result = (num1 + num2)
                case "-":
                    result = (num1 - num2)
                case "*":
                    result = (num1 * num2)
                default:    // case "/"
                    result = (num1 / num2)
                }
                if (floor(result) == result){
                    // if the result is actually an integer
                    print("Result: \(Int(result))")
                } else {    // if the result is a float number
                    print("Result: \(result)")
                }
            } else {
                print("Error: Illegal input")
            }
        default:    // other operations
            print("Error: Illegal operation input")
        }
    } else {    // if the first input is illegal
        print("Error: Illegal input")
    }

}


