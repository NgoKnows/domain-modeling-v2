//
//  ExtensionTests.swift
//  SimpleDomainModel
//
//  Created by Alex Ngo on 4/19/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation
import XCTest

class ExtensionTest: XCTestCase {
  func testCreateMoney() {
    let tenUSD = 10.0.USD
    XCTAssert(tenUSD.amount == 10)
    XCTAssert(tenUSD.currency == "USD")
    
    let fourGBP = 4.0.GBP
    XCTAssert(fourGBP.amount == 4)
    XCTAssert(fourGBP.currency == "GBP")
    
    let oneYEN = 1.0.YEN
    XCTAssert(oneYEN.amount == 1)
    XCTAssert(oneYEN.currency == "YEN")
  }
}