import UIKit

var greeting = "Hello, playground"
protocol HomeworkService {
    // Функция деления с остатком, должна вернуть в первой части результат деления, во второй части остаток.
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int)

    // Функция должна вернуть числа фибоначчи.
    func fibonacci(n: Int) -> [Int]

    // Функция должна выполнить сортировку пузырьком.
    func sort(rawArray: [Int]) -> [Int]

    // Функция должна преобразовать массив строк в массив первых символов строки.
    func firstLetter(strings: [String]) -> [Character]

    // Функция должна отфильтровать массив по условию, которое приходит в параметре `condition`. (Нельзя юзать `filter` у `Array`)
    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int]
}

struct Realization: HomeworkService {
    func divideWithRemainder(_ x: Int, by y: Int) -> (Int, Int) {
        var res_div: Int = x/y
        var rem_div: Int = x%y
        return (res_div, rem_div)
        
    }
    
    func fibonacci(n: Int) -> [Int] {
        var array = [Int] ()
        for i in 0 ... n {
            if i == 0 {
                array.append(0)
            }
            else if i == 1 {
                array.append(1)
            }
            else {
                array.append ( array [i-1] + array [i-2] )
            }
        }
        return array
    }
    
    
    func sort(rawArray: [Int]) -> [Int] {
        var array = rawArray
        for i in 1 ... array.count {
            for j in 0 ..< array.count - i {
                if array[j] > array[j+1] {
                    let swap = array[j]
                    array[j] = array[j+1]
                    array[j+1] = swap
                }
            }
        }
        return array
    }
    
    func firstLetter(strings: [String]) -> [Character] {
        var char = [Character] ()
        for i in strings {
            if let firstChar = i.first {
                char.append(firstChar)
            }
        }
        return char
    }
    
    func filter(array: [Int], condition: ((Int) -> Bool)) -> [Int] {
        var arr = array
        var newArr = [Int] ()
        for i in arr {
            if condition(i) {
                newArr.append(i)
            }
        }
        return newArr
    }
}

var r = Realization()
r.divideWithRemainder(10, by: 3)
r.fibonacci(n: 10)
let myArray = [10, 7, 3, 1, 8]
r.sort(rawArray: myArray)
let strArray = ["mom", "dad", "bro", "sis"]
r.firstLetter(strings: strArray)
func conditionForFilter(n: Int) -> Bool {
    if n%2 == 0 {
        return true
    }
    return false
}
r.filter(array: myArray, condition: conditionForFilter)
