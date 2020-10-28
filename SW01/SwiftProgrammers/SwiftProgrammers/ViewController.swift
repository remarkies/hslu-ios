//
//  ViewController.swift
//  SwiftProgrammers
//
//  Created by Luka Kramer on 21.09.20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Title
        let label = UILabel(frame: CGRect(x: 24, y: 24, width: 351, height: 100))
        label.text = "Swift-Programmers"
        label.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.view.addSubview(label)
        
        //Dataprovider
        let usePersonData = false
        let dataProvider = DataProvider.sharedInstance
        
        if(!usePersonData) {
            for (index, data) in dataProvider.memberNames.enumerated() {
                addLabel(name: data, position: index)
            }
        }
        
        if(usePersonData) {
            for (index, data) in dataProvider.memberPersons.enumerated() {
                addLabel(pers: data, position: index)
            }
        }
    }
    
    func addLabel(name: String, position: Int) {
        let label = UILabel(frame: CGRect(x: 24, y: 24, width: 351, height: 200 + (position * 50)))
        label.text = name
        label.textColor = #colorLiteral(red: 0.481865285, green: 0.481865285, blue: 0.481865285, alpha: 1)
        self.view.addSubview(label)
    }
    
    func addLabel(pers: Person, position: Int) {
        let labelFirstName = UILabel(frame: CGRect(x: 24, y: 24, width: 351, height: 200 + (position * 50)))
        labelFirstName.text = pers.firstName
        labelFirstName.textColor = #colorLiteral(red: 0.481865285, green: 0.481865285, blue: 0.481865285, alpha: 1)
        self.view.addSubview(labelFirstName)
        let labelLastName = UILabel(frame: CGRect(x: 104, y: 24, width: 351, height: 200 + (position * 50)))
        labelLastName.text = pers.lastName
        labelLastName.textColor = #colorLiteral(red: 0.481865285, green: 0.481865285, blue: 0.481865285, alpha: 1)
        self.view.addSubview(labelLastName)
        let labelPlz = UILabel(frame: CGRect(x: 234, y: 24, width: 351, height: 200 + (position * 50)))
        labelPlz.text = String(pers.plz)
        labelPlz.textColor = #colorLiteral(red: 0.481865285, green: 0.481865285, blue: 0.481865285, alpha: 1)
        self.view.addSubview(labelPlz)
    }


}

