//
//  CarWash.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 05.05.2023.
//

import Foundation
/**
 1. Есть автомойка и есть админ здание;
 2. И то, и другое является зданием;
 3. Каждое из них имеет отдельные помещения;
 4. Каждое помещение рассчитано на определенное количество людей;
 5. У автомойки помещения могут еще вмещать и машины;
 6. Работники автомойки деляцца на мойщиков, бухгалтеров и директоров;
 7. Все они - люди, у которых разная зарплата, опыт работы и обязанности;
 8. Бухгалтера считают деньги;
 9. Директора получают прибыль;
 10. Мойщики моют машины;
 11. Финансовые потоки идут по пути обработки машины - мойщики - бухгалтера - директора;
 12. Есть машины, у которых есть деньги, до мойки они грязные, а после мойки чистые.
 13. Есть одно здание мойки с одной комнатой и одним мойщиком
 14. Есть одно здание администрации с одной комнатой, в которой сидит бухгалтер и директор.
 Задание:
 Придумать и реализовать иерархию классов автомойки, учитывая, что используецца следуюший процесс взаимодействий:
 1. Мойщику мойки отдают машину
 2. Мойщик моет машину
 3. Мойщик забирает деньги у машины
 4. Мойщик отдает деньги бухгалтеру
 5. Бухгалтер считает деньги
 6. Бухгалтер отдает деньги директору
 7. Директор получает прибыль
 */

// MARK: -
// MARK: BUILDINGS

class Building {
    let rooms: [Room]
    init(rooms: [Room]) {
        self.rooms = rooms
    }
}

class Room {
    let capacity: Int
    let people: [Employee] = []
    var currentLoad: Int = 0
    init(capacity: Int) {
        self.capacity = capacity
    }
}

class CarWashRoom: Room {
    let carCapacity: Int
    let carsRoom: [Car] = []
    
    init(capacity: Int, carCapacity: Int) {
        self.carCapacity = carCapacity
        super.init(capacity: capacity)
    }
}



class CarWasn: Building {
    
    func giveCar(to washer: Washer) {
        // cycle to find free washer
        // if there is free washer find a free room add car to the room 
    }
    
    func add(emloyee: Employee) {
        // cycle to find free room, and if it is present add employee
    }
    
    func add(car: Car) {
        // cycle to find free car room, and if it is present add employee
    }
}

// maybe unnessesary class, could be just building
class AdminBuilding: Building {
    
}

// MARK: -
// MARK: People

class Employee {
    let salary: Money
    let experience: Int
    var money: Money

    init(salary: Money, experience: Int) {
        self.salary = salary
        self.experience = experience
        self.money = Money(value: 0)
    }
}


class Director: Employee {
    
    
    func takeMoney(money: Money, from: Accountant) {
    }
    
    func calculateBalance() -> Money {
        return Money(value: 0)
    }
}

class Accountant: Employee {
    func calculateMoney() -> Int {
        return Int.max
    }
}

class Washer: Employee {
    func wash(car: Car) {
        car.isDirty = false
    }
    
    func collectPayment(car: Car) -> Money {
        // Minus car money, plus washer money
        return Money(value: 5)
    }
    
    func givePayment(to accountant: Accountant) {
        // minus washer money, pluc accountant money
    }
}

// MARK: -
// MARK: Money

class Money {
    private(set) var value: Double {
        willSet {
            if value < 0 {
                fatalError("Not enough money")
            }
        }
    }
    
    init(value: Double) {
        self.value = value
    }
    
    func subtract(amount: Money) {
        self.value -= amount.value
    }

    func add(amount: Money) {
        self.value += amount.value
    }
    
    func balance() -> Double {
        return self.value
    }
}

// MARK: -
// MARK: Car

class Car {
    var isDirty: Bool
    var money: Money
    
    init(isDirty: Bool, money: Double) {
        self.isDirty = isDirty
        self.money = Money(value: money)
    }
}


//12. Есть машины, у которых есть деньги, до мойки они грязные, а после мойки чистые.

let car = Car(isDirty: true, money: 100)

let carWash = CarWasn(rooms: [Room(capacity: 2)])
let adminBuilding = AdminBuilding(rooms: [Room(capacity: 2)])









