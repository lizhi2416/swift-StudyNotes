//swift语言特点
/*
 1.变量使用之前必须初始化
 2.数组越界错误自动检查
 3.整形变量内存溢出检测
 4.可选概念的引入让nil值操作更加简单明了
 5.自动内存管理ARC
 6.异常错误y
 */


/*
 swift4版本相比swift3有哪些改进
 1.
 2.@objc修饰符的加入
 3.在类型定义文件中扩展类型，扩展可以使用本类型的私有变量
 4.swift3定义的framework可以一次性装换成swift4
 */

//swift判断版本可以使用
#if swift(>=3.2)
print("swift版本>=3.2");
#endif


//疑问----swift每个版本更新这么大，如何做iOS系统版本适配呢？？？？？？？？？？

print("Hello, world!")
/*
 swift特点
 1.无需导入对应的库文件操作字符串
 2.代码写在全局区域，那么整个项目都可以调用，所以也不需要mian函数
 3.每行代码结尾都不需要写";"
 */

/*
 1.let声明一个常量，var声明变量；编译时无需知道常量的值，但是你必须给他赋予一个值，这意味着你可以用常量表示一个值，
 然后在其他地方调用
 2.常量变量两边都必须有相同的值类型，如果值的类型够明显则编译器会自动类型推断，变量常量签名就无需加类型标注了
 3.类型推断是系统安全的，永远不会推断成不同的类型
 4.用“\()”来转换成对应的打印信息(也可以重写description方法改变)
 5.使用"""+内容+"""来书写带换行的文本，而OC只能使用\n
 */
var myVariable = 42

myVariable = 50

let myConstant = 42

let implicitInteger = 70//含蓄（也就是自动类型推断为）整形

let implicitDouble = 70.0//自动推断为double

let explicitDouble: Double = 70//明确为double

let explicitFloat: Float = 4//明确声明为float

let label = "The width is "

let width = 94

let widthLabel = label + String(width)

let labelInt: Int? = Int(label)

var labelWidth = width

if let labelIntValue = labelInt {//将label = "50"数字字符串则可以得到整型值
    labelWidth += labelIntValue
    print("come in come in")
}

print("label int value is \(String(describing: labelInt)) and labelWidth is \(labelWidth)")

let apples = 3

let oranges = 5

let appleSummary = "I have \(apples) apples"

let fruitSummary = "I have \(apples+oranges) pieces of fruit."

let scale: Float = 0.999

let scaleDescription = "this is \(scale) scale"

let quotation = """
Even though there's whitespace to the left,

the actual lines aren't indented.

Except for this line.

Double quotes (") can appear without being
       escaped.



I still have \(apples+oranges) pieces of
  fruit.

"""

print("\n\(quotation)")




/*
 swift数组和字典用[]来表示，元素之间用","逗号隔开
 */
var shoppingList = ["catfish", "water", "tulips", "blue paint"]

shoppingList[1] = "bottle of water"//瓶装水

var occupations = [
    "lizhi": "iOS developer",
    "guiliange": "andirod developer",
]

occupations["laihualai"] = "product designer"

//创建空数组和空字典
let emptyArray = [String]()

let emptyAnyArray = [Any]()

let emptyDictionary = [String: Float]()

let emptyAnyDict = [Float: Any]()

//如果类型推断可以判定类型则可以直接按下面的写法
shoppingList = []
occupations = [:]


//let emptyAnyDict = [Any: Float]()这种写法会报错Hashable，没有遵循does not conform to protocol 'Hashable'协议，也就是字典的key必须是Hashable,因为字典的key是存在重复的，系统必须根据哈希值来判定是否有重复的key，这等同于集合Set的概念；
/*
 
 一个类型为了存储在集合中，该类型必须是可哈希化的-该类型必须提供一种方法计算它的哈希值，一个哈希值为Int类型，相等的对象哈希值必须相同。
 Swift的所有基本类型（形如String，Int，Double，Bool）默认是可哈希化的，可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值默认也是可哈希化的
 
 public protocol Hashable : Equatable {
 
 /// The hash value.
 ///
 /// Hash values are not guaranteed to be equal across different executions of
 /// your program. Do not save hash values to use during a future execution.
 public var hashValue: Int { get }
 }
 这里可以看到Hashable协议集成于Equatable协议
 public protocol Equatable {
 
 /// Returns a Boolean value indicating whether two values are equal.
 ///
 /// Equality is the inverse of inequality. For any values `a` and `b`,
 /// `a == b` implies that `a != b` is `false`.
 ///
 /// - Parameters:
 ///   - lhs: A value to compare.
 ///   - rhs: Another value to compare.
 public static func ==(lhs: Self, rhs: Self) -> Bool
 
 ***********
 所以自定义一个准守哈希协议的类型必须实现两个方法
 public var hashValue: Int { get }
 public static func ==(lhs: Self, rhs: Self) -> Bool
 ***************
 
 }
 具体可参考简书“Swift - Hashable 和 Equatable 协议”-链接https://www.jianshu.com/p/5eb7c02f82d3
 */


/*
 控制流
 
 用if和switch做判断，用for-in，while，repeat-while来实现循环
 if判断条件必须是bool，而OC则可以默认判断是否为0
 使用if let来判定可选值或者用??提供默认值
 switch支持多种类型，不和OC一样仅限于整形
 */
let individualScores = [75, 43, 103, 87, 12]

var teamScore = 0

for score in individualScores {
    if score>50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

print(teamScore)

var optionalString: String? = "hello"

print(optionalString == nil)

var optionName: String? = "lizhi jiang"

var greeting = "Hello"

//if let
if let name = optionName {
    greeting = "Hello, \(name)"
    print(greeting)
}
//用??提供默认值
let nickName: String? = nil

let fullName: String = "min xia"

let informalGreeting = "Hi \(nickName ?? fullName)"

let vegetable = "red pepper"

switch vegetable {//switch条件判断必须彻底，不能有遗漏，也就是说不能存在没有default
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "waatercress":
    print("That would make a good tea andwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}


let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest = 0

for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest += number
        }
    }
}
print(largest)

var n = 2

while n < 100 {
    n *= 2
}
print(n)

var m = 2

repeat {//repeat-while先执行再判断，所以至少执行一次
    m *= 2
} while m < 100

print(m)

var total = 0

for i in 0..<4 {//a..<b不包含b值，a...b包含b值
    total += i
}
print(total)

/*
 函数和闭包
 
 1.函数可以嵌套函数
 2.函数是第一类型，可以用作另一个函数的返回值,也可以作为另一个函数的参数，不管数作为参数还是返回值，都只需要传函数名就可以了，这里的函数名指的就是函数的地址
 3.闭包是特殊的函数，闭包值捕获功能
 */
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)"
}

print(greet(person: "Jim", day: "Tuesday"))

func greet(to person: String, _ day: String) -> String {
    return "Hello \(person), today is \(day)"
}

//元组用来存储连续多个值
func calculateStatisistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        sum += score
        if score < min {
            min = score
        }
        if score > max {
            max = score
        }
    }
    
    return (min, max, sum)
}

let statistics = calculateStatisistics(scores: [5, 3, 100, 3, 9])

print(statistics.max, statistics.min, statistics.sum)

print(statistics.2)//元组也是可以用下标得到值的

func returnFifteen() -> Int {
    var x = 10
    
    func add() {
        x += 5
    }
    
    add()
    
    return x
}

print(returnFifteen())

func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne//返回函数名就可以，函数作为返回值
}

var increment = makeIncrementer()

print(increment(100))

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]

hasAnyMatches(list: numbers, condition: lessThanTen)//函数作为函数的参数

//闭包的标准格式为({参数与返回值之间用In分割})
numbers.map ({ (num: Int) -> Int in
    return 3 * num
})

let mappedNumbers = numbers.map({ (num) in
    3 * num
})

print(mappedNumbers)

let sortedNumbers = numbers.sorted { $0 > $1 }

print(sortedNumbers)


/*
 Objects and Classes 对象和类
 1.在类的context里属性，方法，函数声明会有所不同
 2.在类名后面加“（）”创建一个实例，用点语法访问实例的属性和方法
 */

class Shape {
    var name: String
    
    var numberOfSides = 0
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
    func shapeDescription() -> String {
        return "\(name) with \(numberOfSides) sides"
    }
    
    init(name: String) {
        self.name = name
    }
}

var shape = Shape(name: "")

shape.numberOfSides = 7

var shapeDescription = shape.simpleDescription()

class Square: Shape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
    
}

let test = Square(sideLength: 5.20, name: "my test square")

print(test.area(),test.simpleDescription())


class Circle: Shape {
    var radius: Double
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 1
    }
    
    func area() -> Double {
        return 3.1415926 * radius * radius
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius \(radius)"
    }
    
}


class EquilateralTriangle: Shape {
    var sideLength = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var 周长: Double {
        get {
            return 3.0 * sideLength
        }
        
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return ""
    }
    
}

var triangle = EquilateralTriangle(sideLength: 3.3, name: "a triangle")

print(triangle.周长)

triangle.周长 = 12.6

print(triangle.sideLength)

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
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

var triangleAndSquare = TriangleAndSquare(size: 10.0, name: "another test shape")

print(triangleAndSquare.square.sideLength)

print(triangleAndSquare.triangle.sideLength)

triangleAndSquare.square = Square(sideLength: 50, name: "larger square")

print(triangleAndSquare.triangle.sideLength)

let optionSquare: Square? = Square(sideLength: 2.5, name: "optional square")

let sideLength = optionSquare?.sideLength

/*
 Enumerations and Structures 枚举和结构体
 1.swift默认给枚举第一个值的rawValue为0，后面的一次递增，但是你可以手动指定响应的rawvalue
 2.swift中枚举的rawvalue也可以是字符串string，浮点型float
 3.用init？（rawvalue：）初始化一个枚举可能为nil
 4.结构体支持很多与类相同的方法，init初始化。。。结构体与class类最大的区别是传值是用的copy（也就是值类型）而类是引用计数类型
 */

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

print(ace,aceRawValue)

func compareRank(rank1: Rank, rank2: Rank) -> Bool {
    return rank1.rawValue > rank2.rawValue
}

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
    print(threeDescription)
}

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
        
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        default:
            return "red"
        }
    }
}

let hearts = Suit.hearts

print(hearts.simpleDescription(),hearts.color())

enum ServerResponse {
    case result(String, String)
    case failure(String)
    case timeout(code: Int)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")

let failure = ServerResponse.failure("out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
case let .failure(message):
    print("Failure... \(message)")
case let .timeout(code):
    print("timeout with code \(code)")
}

struct Card {
    var rank: Rank
    
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription()))"
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)

let threeOfSpadesDescription = threeOfSpades.simpleDescription()

/*
 protocol and extension 协议和类别
 1.classes,enumerations,structs都可以准守协议
 2.extension可以给类型添加方法和计算属性等
 3.使用extension去准守协议
 4.可以用协议来表示一个类型
 */

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    
    var anotherProperty: Int = 69105
    
    func adjust() {
        simpleDescription += "Now 100% adjusted."
    }
}

var a = SimpleClass()

a.adjust()

let aDescription = a.simpleDescription

print(aDescription)

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()

b.adjust()

let bDescription = b.simpleDescription

enum SimpleEnum: ExampleProtocol {
    var simpleDescription: String {//枚举不能存在stored储存属性,所以这里写计算属性
        get {
            return "A simple enum"
        }
        set {
            simpleDescription = newValue
        }
    }
    
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}

print(7.simpleDescription)

extension Double: ExampleProtocol {
    var simpleDescription: String {
        return "The Double is \(self)"
    }
    
    mutating func adjust() {
        if self < 0 {
            self = -self
        }
    }
}

var hehe = -3.1415926

hehe.adjust()

print(hehe.simpleDescription)

let protocolValue: ExampleProtocol = a//即时在运行时期间protocolValue有其他属性或方法，编译器也只会把它当做ExampleProtocol来对待，只能访问ExampleProtocol中的属性和方法

print(protocolValue.simpleDescription)

/*
 Error Handling 错误操作
 1.使用
 */

enum PrinterError: Error {
    
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
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    
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
    print("printer error: \(printerError)")
} catch {
    print(error)
}

let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")

let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

var fridgeIsOpen = false

let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    let result = fridgeContent.contains(food)
    return result
}

fridgeContains("banana")

print(fridgeIsOpen)

/*
 Generics泛型--在<name>中写上名称表示一个泛型
 */

func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

print(makeArray(repeating: "konck", numberOfTimes: 14))

//where的使用,Sequence代表集合list的意思,也就是可以遍历的 <T:Equatable>等同于<T> ... where T: Equatable
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Iterator.Element:Equatable, T.Iterator.Element == U.Iterator.Element {
    for lhsItem in rhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

print(anyCommonElements([1, 2, 3], [3]))















