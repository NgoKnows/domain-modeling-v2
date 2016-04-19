//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}


protocol Mathematics {
  func add(to: Money) -> Money
  func subtract(to: Money) -> Money
}

extension Double  {
  var USD: Money { return Money(amount: Int(self), currency: "USD") }
  var GBP: Money { return Money(amount: Int(self), currency: "GBP") }
  var EUR: Money { return Money(amount: Int(self), currency: "EUR") }
  var YEN: Money { return Money(amount: Int(self), currency: "YEN") }
}

////////////////////////////////////
// Money
//
public struct Money: CustomStringConvertible, Mathematics {
  public var amount : Int
  public var currency : String
    
    public var description: String {
        return currency + String(amount)
    }
  
  public func convert(to: String) -> Money {
    var exchange:[String: Double] = ["USD": 1.0, "GBP": 2.0, "EUR": 2/3, "CAN": 4/5]

    let selfMoney = exchange[self.currency]! * Double(self.amount)
    let rate = 1.0 / exchange[to]!
    return Money(amount: Int(selfMoney * rate), currency: to)
  }
  
  public func add(to: Money) -> Money {
    var exchange:[String: Double] = ["USD": 1.0, "GBP": 2.0, "EUR": 2/3, "CAN": 4/5]

    let selfMoney = exchange[self.currency]! * Double(self.amount)
    let otherMoney = exchange[to.currency]! * Double(to.amount)
    
    let converted = (selfMoney + otherMoney) * (1.0 / exchange[to.currency]!)
    return Money(amount: Int(converted), currency: to.currency)
  }
  
  public func subtract(from: Money) -> Money {
    var exchange:[String: Double] = ["USD": 1.0, "GBP": 2.0, "EUR": 2/3, "CAN": 4/5]

    let selfMoney = exchange[self.currency]! * Double(self.amount)
    let otherMoney = exchange[from.currency]! * Double(from.amount)
    
    let converted = (selfMoney - otherMoney) * (1.0 / exchange[from.currency]!)

    return Money(amount: Int(converted), currency: self.currency)
  }
}



//////////////////////////////////////
// Job
//
public class Job: CustomStringConvertible {
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
    
    public var type : JobType
    public var title : String
    public var description: String {
        return self.title
    }

  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  public func calculateIncome(hours: Int) -> Int {
    switch self.type {
    case .Hourly(let rate):
        return Int(Double(hours) * rate)
    case .Salary(let salary):
        return salary
    }
  }
  
  public func raise(amt : Double) {
    switch self.type {
    case .Hourly(let rate):
        self.type = JobType.Hourly(rate + amt)
    case .Salary(let salary):
        self.type = JobType.Salary(Int(Double(salary) + amt))
    }
  }
}



////////////////////////////////////
// Person
//
public class Person: CustomStringConvertible {
  public var firstName : String = ""
  public var lastName : String = ""
  public var age : Int = 0
  private var _job : Job? = nil
  private var _spouse : Person? = nil
    
  public var job : Job? {
    get {
        return self._job
    }
    
    set(value) {
        if (self.age >= 16) {
            self._job = value!
        }
    }
  }
  
  public var spouse : Person? {
    get {
        return self._spouse
    }
    set(value) {
        if (self.age >= 18) {
            self._spouse = value!
        }
    }
  }
    
    public var description: String {
        return "I am \(firstName) \(lastName)"
    }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  public func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]"
  }
}


////////////////////////////////////
// Family
//
public class Family: CustomStringConvertible {
  private var members : [Person] = []
    
    public var description: String {
        var description = ""
        for person in self.members {
          description += "\(person.firstName) \(person.lastName)\n"
        }
        return description
    }
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil && (spouse1.age >= 21 || spouse2.age >= 21) {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        
        self.members.append(spouse1)
        self.members.append(spouse2)
    } else {
        exit(1)
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    self.members.append(child)
    return true
  }
  
  public func householdIncome() -> Int {
    var total = 0
    for member in members {
        if ((member.job) != nil) {
            switch member.job!.type {
            case .Hourly(let rate):
                total += Int(rate * 40 * 50)
            case .Salary(let salary):
                total += salary
            }
        }
    }
    return total
  }
}





