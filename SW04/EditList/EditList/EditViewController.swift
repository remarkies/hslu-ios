//
//  EditViewController.swift
//  EditList
//
//  Created by Luka Kramer on 06.10.20.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    weak var textFieldShouldReturn: UITextFieldDelegate?

    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstnameTextField.text = person.firstName
        lastnameTextField.text = person.lastName
        postalCodeTextField.text = String(person.plz)
        print(person.id, person.firstName, person.lastName, person.plz)
    }
    
    @IBAction func saveCloseButtonPressed(_ sender: Any) {
        
        var result = DataProvider.findPerson(id: person.id)
        
        print(result.firstName, result.lastName, result.plz)
        
        if(firstnameTextField.text != nil && lastnameTextField.text != nil && postalCodeTextField.text != nil) {
            result.firstName = String(firstnameTextField.text!)
            result.lastName = String(lastnameTextField.text!)
            result.plz = Int(postalCodeTextField.text!) ?? 0
            
            result = DataProvider.findPerson(id: person.id)
            
            print(result.firstName, result.lastName, result.plz)
            
            self.dismiss(animated: true, completion: nil)
        } else {
            print("form not correctly filled out")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textfieldshouldreturn")
        if textField == firstnameTextField {
            textField.resignFirstResponder()//
            lastnameTextField.becomeFirstResponder()//TF2 will respond immediately after TF1 resign.
        } else if textField == lastnameTextField  {
            textField.resignFirstResponder()
            postalCodeTextField.becomeFirstResponder()//TF3 will respond first
        } else if textField == postalCodeTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
