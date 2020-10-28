//
//  EditViewController.swift
//  Persistency
//
//  Created by Luka Kramer on 19.10.20.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var person: Person!
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if person.name != nil {
            navigationBar.topItem?.title = person.name
            nameTextField.text = person.name
        } else {
            navigationBar.topItem?.title = "New User"
        }
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindDetail", sender: sender)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        person.name = nameTextField.text
        do {
            try managedContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        performSegue(withIdentifier: "unwindDetail", sender: sender)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
