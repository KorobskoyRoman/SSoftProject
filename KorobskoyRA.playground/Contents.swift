//// 1
//// Определить две константы a и b типа Double, присвоить им любые значения. Вычислить среднее значение и сохранить результат в переменную avarage.
//
//let a: Double = 2.5
//let b: Double = 5
//
//var avarage = (a + b) / 2
//
//// 2
//// Создать кортеж, и задать два любых строковых значения с названиями firstName и lastName. Далее необходимо вывести в консоль строку в формате "Full name: [firstName] [lastName]".
//
//let tuple = (firstName: "Roman", lastName: "Korobskoy")
//print("Full name: \(tuple.firstName) \(tuple.lastName)")
//
//// 3
//// Создать две опциональные переменные типа Float.
///Одной из них задать первоначальное значение.
///Написать функцию, которая принимает на вход опциональную переменную типа Float. Функция должна безопасно извлечь значение из входящей переменной.
///Если значение удалось получить - необходимо вывести его в консоль, если значение у переменной отсутствует вывести в консоль фразу "Variable can't be unwrapped".
///Вызвать функцию дважды с двумя ранее созданными переменными.
//
//var floatA: Float?
//var floatB: Float? = 2.5
//
//func checkNil(number: Float?) {
//    if let number = number {
//        print(number)
//    } else {
//        print("Variable can't be unwrapped")
//    }
//}
//
//checkNil(number: floatA)
//checkNil(number: floatB)
//
//// 4
//// Напишите программу для вывода первых 15 чисел последовательности Фибоначчи
//
//func fibonacci(n: Int) {
//    var num1 = 0
//    var num2 = 1
//    
//    for _ in 0 ..< n {
//        print(num1)
//        let num = num1 + num2
//        num1 = num2
//        num2 = num
//    }
//}
//
//fibonacci(n: 15)
//
//// 5
//// Напишите программу для сортировки массива, использующую метод пузырька. Сортировка должна происходить в отдельной функции, принимающей на вход исходный массив.
//
//func sort(array: [Int]) -> [Int] {
//    var sortedArray = array
//    for i in 0..<(sortedArray.count-1) { // sortedArray.count-1 - кол-во этераций цикла
//        for i in 0..<(sortedArray.count-1-i) {
//            if sortedArray[i] > sortedArray[i+1] { //сравниваем текущий элемент со следующим
//                sortedArray.swapAt(i, i+1) // меняем местами
//            }
//        }
//    }
//    print(sortedArray)
//    return sortedArray
//}
//
//sort(array: [3,1,2,6,5,7,8,7,6,5])
//
//// 6
//// Напишите программу, решающую задачу: есть входящая строка формата "abc123",
///где сначала идет любая последовательность букв, потом число. Необходимо получить новую строку,
///в конце которой будет число на единицу больше предыдущего, то есть "abc124".
//
//func convertString(string: String) -> String {
//    var mutateString = string
//    let lastChar = Int(String(mutateString[mutateString.index(before: mutateString.endIndex)])) // определяем последний символ
//    guard var lastChar = lastChar else { return "" }
//    print(lastChar)
//    if lastChar != 9 { // проверяем наличие
//        lastChar += 1 // прибавляем 1 к последнему символу
//        mutateString.removeLast() // удаляем старый
//        mutateString.insert(Character("\(lastChar)"), at: mutateString.endIndex) // вставляем новый на место старого
//    } else if lastChar == 9 { // проверяем последнюю цифру
//        lastChar = 0 // обнуляем до десятка
//        let preLastChar = Int(String(mutateString[mutateString.index(mutateString.startIndex, offsetBy: mutateString.count - 2)])) // вычисляем предпоследний
//        guard var preLastChar = preLastChar else { return "" }
//        preLastChar += 1 // увеличиваем на 1
//        print(preLastChar)
//        mutateString.remove(at: mutateString.index(mutateString.startIndex, offsetBy: mutateString.count - 2)) // удаляем старый предпоследний символ
//        mutateString.insert(Character("\(preLastChar)"), at: mutateString.index(mutateString.startIndex, offsetBy: mutateString.count - 1)) // добавляем предпоследний
//        mutateString.removeLast() // удаляем старый последний
//        mutateString.insert(Character("\(lastChar)"), at: mutateString.endIndex) // вставляем новый на место старого
//    }
//    return String(mutateString)
//}
//
//convertString(string: "abc129")
