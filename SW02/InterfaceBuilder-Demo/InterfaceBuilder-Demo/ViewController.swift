//
//  ViewController.swift
//  InterfaceBuilder-Demo
//
//  Created by Luka Kramer on 23.09.20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lableValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentValue: UISegmentedControl!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var spinningButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    var isSpinning = false
    var sliderAlertShown = false
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        let step: Float = 1
        let sliderValue = round(slider.value / step) * step
        lableValue.text = String(sliderValue)
        
        if(sliderValue > 70) {
            if(!sliderAlertShown) {
                let alertController = UIAlertController(title: "Info", message: "Slider value is bigger than 70", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                sliderAlertShown = true
            }
        } else {
            if(sliderAlertShown) {
               sliderAlertShown = false
            }
        }
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        switch segmentValue.selectedSegmentIndex {
        case 0:
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 1:
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        default:
            view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        print(segmentValue.selectedSegmentIndex)
    }
    
    @IBAction func spinningButtonPressed(_ sender: Any) {
        isSpinning = !isSpinning
        spinningButton.setTitle(isSpinning ? "Stop spinning" : "Start spinning", for: UIControl.State.normal)
        if(isSpinning) {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    @IBAction func infoButtonTouchUpInside(_ sender: Any) {
        
        let alertController = UIAlertController(
        title: "Information",
        message: "Congratulations, you just pressed the i-Button at the top right! It looks like you're enjoying this beautiful application.. ;)",
        preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(
            title: "OK", style: .cancel,
        handler: nil)
        
        let reallyAction = UIAlertAction(title: "...really?", style: .default, handler: nil)
        
        alertController.addAction(reallyAction)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

