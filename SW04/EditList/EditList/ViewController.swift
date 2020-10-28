//
//  ViewController.swift
//  EditList
//
//  Created by Luka Kramer on 05.10.20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstnameLabel.text = person.firstName
        lastnameLabel.text = person.lastName
        postalCodeLabel.text = String(person.plz)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditViewController
        vc.title = "EditView"
        vc.person = person
    }
    

}

