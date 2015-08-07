//: Playground - noun: a place where people can play

var bucketList = ["Climb Mt. Everest"]
var newItems = ["Fly hot air balloon to Fiji", "Watch the Lord of the Rings Trilogy in one day", "Go on a walkabout", "Scuba dive in the Great Blue Hole", "Find a triple rainbow"]

bucketList += newItems
bucketList.removeAtIndex(2)
println(bucketList.count)
println(bucketList[0...2])
bucketList[2] += " in  Australia"
bucketList[0] = "Climb Mt. Kilimanjaro"
bucketList.insert("Toboggan across Alaska", atIndex: 2)

var myronsList = ["Climb Mt. Kilimanjaro", "Fly hot air balloon to Fiji", "Toboggan across Alaska", "Go on a walkabout in  Australia", "Scuba dive in the Great Blue Hole", "Find a triple rainbow"];let equal = (bucketList == myronsList) //arrays are ordered so false
println(equal)

let lunches = [    "Cheeseburger",    "Veggie Pizza",    "Chicken Caesar Salad",    "Black Bean Burrito",    "Falafel wrap"]

// MARK: Bronze challenge
var toDoList = ["Take out garbage", "Pay bills", "Cross off finished items"]

if toDoList.isEmpty {
   println("empty")
    } else {
        println("not empty")
}




