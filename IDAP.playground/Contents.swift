import UIKit

//Создать объектную структуру данных человек, имеющую поля имя, возраст, пол, количество детей, женат или нет, указатель на партнера, на родителей и на массив с детьми, где могло бы быть, максимум, 20 детей.


// Swift way is to replace class with protocol

class Human {
    private var name: String
    private var age: Int
    private var gender: Gender
    
    enum Gender: String {
        case male = "male"
        case female = "female"
    }
    
    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    func getName() -> String{
        return name
    }
    
    func getAge() -> Int {
        return age
    }
    
    func getGender() -> Gender{
        return gender
    }
    
    func becomeOlder(years: Int) {
        self.age += years
    }
    
    func changeName(to name: String) {
        self.name = name
    }
    
    func changeGender(to gender: Gender) {
        self.gender = gender
    }
}


class Person: Human {
    private var isMarried: Bool
    private var partner: Person?
    private let parents: (father: Person?, mother: Person?)
    var childrenCount: Int {
        return children.count
    }
    
    private var children: [Child] {
        willSet {
            if children.count >= 20 {
                fatalError("A person can have at most 20 children.")
            }
        }
    }
    
    init(name: String, age: Int, gender: Gender, isMarried: Bool, partner: Person? = nil, parents: (father: Person?, mother: Person?), children: [Child] = []) {
        self.isMarried = isMarried
        self.partner = partner
        self.parents = parents
        self.children = children
        
        if children.count > 20 {
            fatalError("A person can have at most 20 children.")
        }
        super.init(name: name, age: age, gender: gender)
    }
    
    func becomeMarried(partner: Person) {
        self.isMarried = true
        partner.isMarried = true
        self.partner = partner
    }
    
    func becomeDivorced() {
        self.isMarried = false
        partner?.isMarried = false
        self.partner = nil
    }
    
    func makeChild(name: String, gender: Gender, with partner: Person) {
        
        let parents: (father: Person?, mother: Person?) = self.getGender() == .male ? (self, partner) : (partner, self)
        let child = Child(name: name, age: 0, gender: gender, parents: parents)
        if self.children.count < 20 && partner.children.count < 20 {
            self.appendChild(child)
            partner.appendChild(child)
        } else {
            fatalError("A person can have at most 20 children.")
        }
    }
    
    func appendChild(_ child: Child) {
        self.children.append(child)
    }
    
    func getMarriageStatus() -> Bool {
        return self.isMarried
    }
    
    func getPartner() -> Person? {
        return self.partner
    }
    
    func getChildren() -> [Child] {
        return self.children
    }
}


class Child: Human {
    private var parents: (father: Person?, mother: Person?)
    
    init(name: String, age: Int = 0, gender: Gender, parents: (father: Person?, mother: Person?)) {
        self.parents = parents
        super.init(name: name, age: age, gender: gender)
    }
    
    func getParents() -> (Person?, Person?) {
        return parents
    }
}



let danil = Human(name: "Danil", age: 15, gender: .male)
let newMan = Person(name: "Ivan", age: 20, gender: .male, isMarried: false, parents: (nil, nil))
let newWoman = Person(name: "Lera", age: 16, gender: .female, isMarried: false, parents: (nil, nil))

newMan.childrenCount
newMan.getMarriageStatus()

newMan.becomeMarried(partner: newWoman)
newMan.getMarriageStatus()
newWoman.getMarriageStatus()

newMan.makeChild(name: "Sam", gender: .male, with: newWoman)
newMan.makeChild(name: "Sam", gender: .male, with: newWoman)
newMan.childrenCount
newWoman.childrenCount
