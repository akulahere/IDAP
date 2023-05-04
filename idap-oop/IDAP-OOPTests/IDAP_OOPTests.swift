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

final class ChildTests: QuickSpec {
    override func spec() {
        describe("Child") {
            var child: Child!
            var father: Human!
            var mother: Human!
            
            beforeEach {
                father = Human(name: "John", age: 35, gender: .male)
                mother = Human(name: "Jane", age: 32, gender: .female)
                child = Child(name: "Alice", age: 5, gender: .female, parents: (father, mother))
            }
            
            afterEach {
                child = nil
                father = nil
                mother = nil
            }
            
            it("should have the correct initial state") {
                expect(child.name).to(equal("Alice"))
                expect(child.gender).to(equal(Gender.female))
            }
        }
    }
}

