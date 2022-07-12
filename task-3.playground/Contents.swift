// 1
//Написать простое замыкание в переменной myClosure, замыкание должно выводить в консоль фразу "I love Swift". Вызвать это замыкание. Далее написать функцию, которая будет запускать заданное замыкание заданное количество раз. Объявить функцию так: func repeatTask (times: Int, task: () -> Void). Функция должна запускать times раз замыкание task . Используйте эту функцию для печати «I love Swift» 10 раз.

let myClosure: () -> Void = { print("i love swift")}

myClosure

func repeatTask(times: Int, task: () -> Void){
    var i = 0
    repeat {
        task()
        i += 1
    }
    while i < times
}

repeatTask(times: 10, task: myClosure)

// 2
// Условия: есть начальная позиция на двумерной плоскости, можно осуществлять последовательность шагов по четырем направлениям up, down, left, right. Размерность каждого шага равна 1. Создать перечисление Directions с направлениями движения. Создать переменную location с начальными координатами (0,0), создать массив элементами которого будут направления из перечисления. Положить в этот массив следующую последовательность шагов: [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]. Програмно вычислить какие будут координаты у переменной location после выполнения этой последовательности шагов.

enum Directions {
    case up, down, left, right
}

var location = (0,0)
let locationArray: [Directions] = [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]

locationArray.map { direction in
    switch direction {
    case .up:
        location.1 += 1
    case .down:
        location.1 -= 1
    case .left:
        location.0 -= 1
    case .right:
        location.0 += 1
    }
    print(location) // для отслеживания перемещения точки
}

print(location) // конечная

// 3
// Создать класс Rectangle с двумя неопциональными свойствами: ширина и длина. Реализовать в этом классе метод вычисляющий и выводящий в консоль периметр прямоугольника. Создать экземпляр класса и вызвать у него этот метод.

class Rectangle {
    let width: Int = 10
    let height: Int = 5
    
    func perimeter() {
        let perimeter = (width + height) * 2
        print("периметр - \(perimeter)")
    }
}

let rectangle = Rectangle()
rectangle.perimeter()

// 4
// Создать расширение класса Rectangle, которое будет обладать вычисляемым свойством площадь. Вывести в консоль площадь уже ранее созданного объекта.

extension Rectangle {
    var area: Int { return width * height }
}

print("площадь - \(rectangle.area)")
