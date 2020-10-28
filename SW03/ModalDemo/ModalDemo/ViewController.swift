//
//  ViewController.swift
//  ModalDemo
//
//  Created by Luka Kramer on 30.09.20.
//

import UIKit

class ViewController: UIViewController {

    var appearanceCounter:Int = 0
    
    
    @IBOutlet weak var counterLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction
    func showSecondButtonPressed() {
        let secondViewController:SecondViewController = SecondViewController()
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func backWithIBAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        appearanceCounter += 1
        
        counterLabel?.text = String(appearanceCounter) + ". appearance"
        
        super.viewWillAppear(true);
    }
}

