//
//  DataProvider.swift
//  SwiftProgrammers
//
//  Created by Luka Kramer on 21.09.20.
//

import Foundation

final class DataProvider : NSObject {
    static let sharedInstance = DataProvider()
    
    var memberNames : [String]
    var memberPersons : [Person]
    
    private override init() {
        memberNames = [String]()
        memberNames.append("Luka")
        memberNames.append("André")
        memberNames.append("Miro")
        memberNames.append("Dariush")
        memberNames.append("Fabien")
        
        memberPersons = [Person]()
        memberPersons.append(Person(firstName: "Luka", lastName: "Kramer", plz: 8134))
        memberPersons.append(Person(firstName: "André", lastName: "Lergier", plz: 6000))
        memberPersons.append(Person(firstName: "Miro", lastName: "Bossert", plz: 8004))
        memberPersons.append(Person(firstName: "Dariush", lastName: "Mehdiaraghi", plz: 8012))
        memberPersons.append(Person(firstName: "Fabien", lastName: "Jeckelmann", plz: 5000))
    }
    
    static func findPerson(id: String) -> Person {
        return DataProvider.sharedInstance.memberPersons.lazy.filter{ p in p.id == id }[0]
    }
}
