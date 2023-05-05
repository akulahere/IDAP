//
//  IDAP_OOPTests.swift
//  IDAP-OOPTests
//
//  Created by Dmytro Akulinin on 04.05.2023.
//
import XCTest
import Quick
import Nimble
@testable import IDAP_OOP

final class HumanSpec: QuickSpec {
    override func spec() {
        describe("Human") {
            var human: Human!
            
            beforeEach {
                human = Human(name: "John", age: 30, gender: .male)
            }
            
            // MARK: Age increasing
            
            it("should increase age by one when calling increaseAge") {
                human.increaseAge()
                expect(human.age).to(equal(31))
            }
        }
        
        describe("Person") {
            var person: Person!
            var father: Human!
            var mother: Human!
            
            beforeEach {
                father = Human(name: "John", age: 30, gender: .male)
                mother = Human(name: "Jane", age: 28, gender: .female)
                person = Person(name: "Alice", age: 25, gender: .female, isMarried: false, partner: nil, parents: (father, mother))
            }
            
            // MARK: Correct Person Init
            
            it("should have correct initial values") {
                expect(person.parents.father).to(beIdenticalTo(father))
                expect(person.parents.mother).to(beIdenticalTo(mother))
                expect(person.children).to(beEmpty())
            }
            
            context("after marriege") {
                var partner: Person!
                
                beforeEach {
                    partner = Person(name: "Bob", age: 27, gender: .male, isMarried: false, partner: nil, parents: (nil, nil))
                    person.becomeMarried(partner: partner)
                }
                
                // MARK: Marriage
                
                it("should update isMarried and partner properties") {
                    expect(person.isMarried).to(beTrue())
                    expect(person.partner).to(beIdenticalTo(partner))
                    expect(partner.isMarried).to(beTrue())
                    expect(partner.partner).to(beIdenticalTo(person))
                }
                
                // MARK: Making child
                
                it("should be able to make a child") {
                    person?.makeChild(name: "Cathy", gender: .female, with: partner)
                    expect(person.children).to(haveCount(1))
                    expect(partner.children).to(haveCount(1))
                    expect(person.children.first?.name).to(equal("Cathy"))
                    expect(person.children.first?.gender).to(equal(Gender.female))
                    expect(partner.children.first?.gender).to(equal(Gender.female))
                    expect((person.children.first as? Child)?.parents.father).to(beIdenticalTo(person.partner))
                    expect((person.children.first as? Child)?.parents.mother).to(beIdenticalTo(person))
                }
                
                context("when divorced") {
                    beforeEach {
                        person?.becomeDivorced()
                    }
                    
                    // MARK: Divorcing
                    
                    it("should update isMarried and partner properties") {
                        expect(person.isMarried).to(beFalse())
                        expect(person.partner).to(beNil())
                        expect(partner.isMarried).to(beFalse())
                        expect(partner.partner).to(beNil())
                    }
                }
            }
        }
        
        describe("Gender") {
            
            // MARK: Gender values
            
            it("should have correct raw values") {
                expect(Gender.male.rawValue).to(equal("male"))
                expect(Gender.female.rawValue).to(equal("female"))
            }
        }
        
        describe("Creature") {
            var creature: Creature!
            
            beforeEach {
                creature = Creature(name: "A",  mass: 10.0, age: 5)
            }
            
            // MARK: Creature init
            
            it("should have no children") {
                expect(creature.children).to(beEmpty())
            }
            
            // MARK: Creature fight
            
            it("fights correctly") {
                expect(creature.fight()).to(equal("A fights!"))
            }
            
            // MARK: Creature give birth
            
            it("gives birth correctly") {
                let baby = creature.giveBirth(to: "B")
                expect(baby.name).to(equal("B"))
                expect(baby.age).to(equal(0))
                expect(baby.mass).to(equal(1.0))
            }
            
            // MARK: Creature add and removes baby correctly
            
            it("adds and removes children correctly") {
                let child = creature.giveBirth(to: "C")
                expect(creature.children).to(beEmpty())
                creature.add(child: child)
                expect(creature.children).to(haveCount(1))
                expect(creature.children.first).to(beIdenticalTo(child))
                
                creature.remove(child: child)
                expect(creature.children).to(beEmpty())
            }
            
            // MARK: Creature say hello
            
            it("says hello correctly") {
                let child1 = Creature(name: "D", mass: 1.0, age: 0)
                let child2 = Creature(name: "E", mass: 1.0, age: 0)
                
                creature.add(child: child1)
                creature.add(child: child2)
                
                expect(creature.sayHello()).to(equal("A says: Hello!\nD says: Hello!\nE says: Hello!"))
            }
        }
    }
}
