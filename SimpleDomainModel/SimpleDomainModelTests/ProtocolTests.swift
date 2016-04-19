//
//  ProtocolTests.swift
//  SimpleDomainModel
//
//  Created by Alex Ngo on 4/18/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest
import SimpleDomainModel

class ProtocolTests: XCTestCase {
    func testMoney() {
        let tenUSD = Money(amount: 10, currency: "USD")
        XCTAssert(tenUSD.description == "USD10")
    }
    
    func testPerson() {
        let ted = Person(firstName: "Ted", lastName: "Neward", age: 45)
        XCTAssert(ted.description == "[Person: firstName:Ted lastName:Neward age:45 job:nil spouse:nil]")
    }
    
    func testJob() {
        let job = Job(title: "Guest Lecturer", type: Job.JobType.Salary(1000))
        XCTAssert(tenUSD.description == "Guest Lecturer")
    }
    

}
