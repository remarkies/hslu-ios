//
//  Person.swift
//  SwiftProgrammers
//
//  Created by Luka Kramer on 21.09.20.
//

import Foundation

class Person {
    var firstName : String
    var lastName : String
    var plz : Int

    init(firstName: String, lastName: String, plz: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.plz = plz
    }
}
