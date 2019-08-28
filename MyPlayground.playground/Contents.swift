import UIKit

//hello,world
var str = "Hello, playground"

print("However,\(str)")

print("""
'rust',
'kotlin',
'swift',
'javacript',
'dart',
""")

//collection
var array1 = ["a","b"]
array1[1] = "c"
array1

var map1 = [
    "a":"b",
]
map1["a"] = "c"
map1

//flow control
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)


//option
let optionName :String? = nil
var greeting = "Hello"
if let name = optionName {
    greeting = "\(greeting),\(name)"
}


let nickname :String? = nil
let informalGreeting = "Hello,\(nickname ?? "unknown")"

//switch (pattern match)
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

//for in dictionary
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

//while and repeat-while
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

//range
for i in 0..<4 {
    for j in 0...3{
        print(i,j)
    }
}

//function
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")

//variable params
func varToTuple(numbers:Int...) -> (a:Int,b:Int,c:Int){
    return (1,1,1)
}

let a = varToTuple(numbers:1,2,3)
a.b
a.2

//array params
func arrayToTuple(numbers:[Int]) -> (Int,Int,Int) {
    return (1,1,1)
}
arrayToTuple(numbers:[1,2,3])


//anonymous function and high order function
func deal(first:(Int)->Int,second:(Int)->Int,initial:Int) -> Int{
    return second(first(initial))
}
func produceAddOne()->((Int)->Int){
    func addOne(initial:Int)->Int {
        return initial+1
    }
    return addOne
}
func multipleTwo(first:Int)->Int{
    return first*2
}

deal(first: produceAddOne(), second: multipleTwo, initial: 1)

//closure
let numbers = [6,1,2,3,4,5]
numbers.map({
    (number:Int)->Int in
    let result = number + 1
    return result
}).filter({
    number in number % 2 == 0
}).map({
    $0/2
    //simular to kotlin? isn't it?
}).reduce(-1){
    $0+$1
}
numbers.sorted(by:){
    $0>$1
}

//escaping closure
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//auto closure(lazy?)
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))

//enum
enum Test {
    case a,b,c,d
}
enum CompassPoint {
    case north
    case south
    case east
    case west
}
var directionToHead = CompassPoint.west

directionToHead = .east

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
for beverage in Beverage.allCases {
    print(beverage)
}

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue
ace.simpleDescription()

//class
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

//willset and didseyt
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
        didSet{
            print("I seemed to be changed")
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

//sturct which similar to singleton
struct Card {
    var rank: Int
    var suit: String
    func simpleDescription() -> String {
        return "The \(rank) of \(suit)"
    }
}
let threeOfSpades = Card(rank: 1, suit: "2")
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

//protocol which similar to interface
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var s = SimpleClass()
s.adjust()
let aDescription = s.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var t = SimpleStructure()
t.adjust()
let bDescription = t.simpleDescription


extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

var protocolValue: ExampleProtocol = 7
protocolValue = s
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty) // Uncomment to see the error

//error and error handling
enum PrinterError:  Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}
do {
    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

//defer which can also be used like try catch finally
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers","banana"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        print("before defer,\(fridgeIsOpen)")
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print("after defer,\(fridgeIsOpen)")

//generic and where condistions
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes:4)

func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
}
anyCommonElements([1, 2, 3], [3])
