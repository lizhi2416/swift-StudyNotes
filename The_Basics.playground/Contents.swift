/*
 基本语法
 */

let cat = "🐱"; print(cat)//一行写多个语句需要用semicolons分号

let minValue = UInt8.min

let maxValue = UInt8.max

print(minValue,maxValue)

//32位或64位电脑环境下Int分别对应Int32和Int64,UInt同样的
//Float32位字节(6位小数点精度),Double 64bit(可以达到15位小数点精度)


/*
 类型安全(Type safety)和类型推断(Type Inference)
 */
let meaningOfLife = 42//Int

let pi = 3.14159//Double Swift always choose Double (rather than Float)

let anotherPi = 3 + 0.14159//Double

let decimalInteger = 17

let binaryInteger = 0b10001

let octalInteger = 0o21

let hexadecimalInteger = 0x11

let twoThousand: UInt16 = 2000

let one: UInt8 = 1

let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3

let pointOneFourOneFiveNine = 0.14159

let actualPi = Double(three) + pointOneFourOneFiveNine

let integerPi = Int(actualPi)

/*
 Type Aliases 重命名
 */

typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min

/*
 Booleans true false
 */
let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

/*
 Tuples 元组,元素可以是不一样的类型, 经常用作函数返回值最有用,但是元组适合于零食的一组相关值，不适合于创建复杂的数据结构，复杂的数据应该考虑使用类class和结构体struct
 */
let http404Error = (404, "Not Found")

let (statuCode, statusMessage) = http404Error

print("The status code is\(statuCode), The status message is \(statusMessage)")

let (justTheStatuCode, _) = http404Error
print("The status code is \(justTheStatuCode)")

//还可以用下标法
print("The statu code is \(http404Error.0)")

let http200Status = (statuCode: 200, description: "OK")

print("The statu code is \(http200Status.statuCode) description is \(http200Status.description)")

/*
 optional 可选值,Swift中的重要概念
 1.C和OC中不存在这个概念，OC中用nil表示一个对象absence不存在,但是针对object对象，结构体，基础C类型，枚举等表示不存在就需要用一个特殊常量来表示（比如NSNotFound表明这个值不存在）
 2.swift的可选值不需要你使用任何特殊常量来表明一个值的不存在,可以解决上面的尴尬问题
 3.swift中的nil不同于OC中的，OC中nil表示一个指针指向一个空对象，而swift是一个类型值不存在，swift中任何可选类型都可以设置为nil，不单单是对象
 */

let possibleNumber = "123"
let convertNumber = Int(possibleNumber)

//去除option警告的三种方式
print(convertNumber ?? "123")//加默认值
print(convertNumber!)//强制解包得到确定的值，容易crash，为nil时会崩溃,且只有可选值类型可以这样用
print(convertNumber as Any)//明确表明为any来解除警告,此时仍为option值

var serverResponseCode: Int? = 404
serverResponseCode = nil

var surveyAnswer: String?//没有提供默认值，则默认为nil

if convertNumber != nil {
    print("converted Number contains some integer value.")
    print("converted Number has an integer value of \(convertNumber!)")
}
//option binding 可选绑定的语法可以理解为给一个var，constant赋值是否成功，如果赋值是nil则不成功if语句就失败,while也可以判断
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber) could not be converted to an integer\"")
}

if var actualNumbers = Int(possibleNumber)  {
    actualNumbers += 1
    print("\(actualNumbers)")
}

//可以使用连续的可选绑定option binding和bool用逗号来分开使用一起判断，如果其中一个是nil或者bool值是false则就会false
if let firstNum = Int("4"), let secondNum = Int("42"), firstNum < secondNum, firstNum < 200 {
    print("hehe")
}
/*
 通过option binding 可选绑定声明的变量或者常量只在这个if语句中有效
 */

/*Error Handing 错误操作*/
func canThrowAnError() throws {
    //this function may or may not throw an error
}

do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

/*Assertions anf Preconditions
 1.断言和先决条件,在runtime时期检测,可以用它们来确保代码执行前某些条件绝对满足
 2.断言和先决条件的不同在于：断言只在debug模式检测，而先决debug和production都检测，因此说断言可以提高生产环境稳定性
 3.Preconditions如果关闭了编译器检测模式则不会执行，编译器会默认条件true，而fatalerrot则不会如此，会一直执行
 */

let age = -3
//assert(age >= 0, "A person's age can't be less than zero.")
if age < 0 {
//    assertionFailure("A person's age can't be less than zero.")
}

//precondition(age > 0, "A person's age can't be less than zero.")
//fatalError()










