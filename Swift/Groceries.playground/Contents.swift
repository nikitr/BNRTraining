//: Playground - noun: a place where people can play

import Cocoa

var groceryBag = Set(["Apples", "Oranges", "Pineapple"]);

for food in groceryBag {
    println(food)
}

let hasBananas = groceryBag.contains("Bananas")
let friendsGroceryBag = Set(["Banana", "Cereal", "Milk", "Oranges"])
let commonGroceryBag = groceryBag.union(friendsGroceryBag)

let roommatesGroceryBag = Set(["Apples", "Bananas", "Cereal", "Toothpaste"])
let itemsToReturn = commonGroceryBag.intersect(roommatesGroceryBag) //the duplicated items

let yourSecondBag = Set(["Berries", "Yogurt"])
let roommatesSecondBag = Set(["Grapes", "Honey"])
let disjoint = yourSecondBag.isDisjointWith(roommatesSecondBag)

