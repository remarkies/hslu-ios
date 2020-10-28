//
//  ViewController.swift
//  Persistency
//
//  Created by Luka Kramer on 19.10.20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var person: Person!
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var counter: Int {
            return UserDefaults.standard.integer(forKey: "counterKey")
        }
        
        UserDefaults.standard.setValue(counter + 1, forKey: "counterKey")
        nameLabel.text = person.name
        counterLabel.text = String(counter)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowEdit" {
            let vc: EditViewController = segue.destination as! EditViewController
            vc.person = self.person
            vc.managedContext = self.managedContext
        }
    }
}

