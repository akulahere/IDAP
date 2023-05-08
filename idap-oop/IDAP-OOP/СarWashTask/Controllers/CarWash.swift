////
////  CarWash.swift
////  IDAP-observer
////
////  Created by Dmytro Akulinin on 05.05.2023.
////
//
//import Foundation
///**
// 1. Есть автомойка и есть админ здание;
// 2. И то, и другое является зданием;
// 3. Каждое из них имеет отдельные помещения;
// 4. Каждое помещение рассчитано на определенное количество людей;
// 5. У автомойки помещения могут еще вмещать и машины;
// 6. Работники автомойки деляцца на мойщиков, бухгалтеров и директоров;
// 7. Все они - люди, у которых разная зарплата, опыт работы и обязанности;
// 8. Бухгалтера считают деньги;
// 9. Директора получают прибыль;
// 10. Мойщики моют машины;
// 11. Финансовые потоки идут по пути обработки машины - мойщики - бухгалтера - директора;
// 12. Есть машины, у которых есть деньги, до мойки они грязные, а после мойки чистые.
// 13. Есть одно здание мойки с одной комнатой и одним мойщиком
// 14. Есть одно здание администрации с одной комнатой, в которой сидит бухгалтер и директор.
// Задание:
// Придумать и реализовать иерархию классов автомойки, учитывая, что используецца следуюший процесс взаимодействий:
// 1. Мойщику мойки отдают машину
// 2. Мойщик моет машину
// 3. Мойщик забирает деньги у машины
// 4. Мойщик отдает деньги бухгалтеру
// 5. Бухгалтер считает деньги
// 6. Бухгалтер отдает деньги директору
// 7. Директор получает прибыль
// */
//

class CarWashController {
    
    // MARK: -
    // MARK: Variables
    
    let washerControllers: [WasherController]
    let accountantController: AccountantController
    let directorController: DirectorController
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        
        self.washerControllers = [
            WasherController(salary: 30.0, experience: 1),
            WasherController(salary: 40.0, experience: 2)
        ]
        
        self.accountantController = AccountantController(salary: 300.0, experience: 5)
        self.directorController = DirectorController(salary: 500.0, experience: 10)
        
        for washerController in washerControllers {
            washerController.delegate = accountantController
        }
        accountantController.delegate = directorController
    }
    
    // MARK: -
    // MARK: Public
    
    func wash(car: Car) {
        guard let freeWasherController = washerControllers.first(where: { $0.isFree == true }) else {
            print("No free washers")
            return
        }
        freeWasherController.process(car: car)
    }
}
