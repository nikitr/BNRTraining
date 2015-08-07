//: Playground - noun: a place where people can play

func printGreeting() {
    println("Hello, playground.")
}
printGreeting()

func printPersonalGreetings(names: String...) {
    for name in names {
        println("Hello \(name), welcome to the playground.")
    }
}
printPersonalGreetings("Alex", "Chris", "Drew", "Pat")

func divisionDescription(#numerator: Double, #denominator: Double,punctuation: String = ".") -> String {
    
    return "\(numerator) divided by \(denominator) equals \(numerator / denominator)\(punctuation)"
}
divisionDescription(numerator: 9.0, denominator: 3.0)
divisionDescription(numerator: 9.0, denominator: 3.0, punctuation: "!")

