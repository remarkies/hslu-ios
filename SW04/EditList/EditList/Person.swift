//
//  Person.swift
//  SwiftProgrammers
//
//  Created by Luka Kramer on 21.09.20.
//

import Foundation

class Person {
    var id: String
    var firstName : String
    var lastName : String
    var plz : Int

    init(firstName: String, lastName: String, plz: Int) {
        self.id = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.plz = plz
    }
}
