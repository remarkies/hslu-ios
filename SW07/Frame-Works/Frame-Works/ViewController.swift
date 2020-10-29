//
//  ViewController.swift
//  Frame-Works
//
//  Created by Luka Kramer on 27.10.20.
//

import UIKit
import MapKit
import EventKit
import EventKitUI
import Contacts
import ContactsUI

class ViewController: UIViewController, EKEventEditViewDelegate, MKMapViewDelegate, CNContactPickerDelegate {
    
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }


    @IBAction func getPersonButtonPressed(_ sender: Any) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.lastnameLabel.text = contact.familyName
        self.firstnameLabel.text = contact.givenName
    }
    
    @IBAction func showHSLUButtonPressed(_ sender: Any) {

        var annotations: [MKPointAnnotation] = []
        
        // HSLU point annotation
        let pointHSLU = MKPointAnnotation()
        pointHSLU.coordinate = CLLocationCoordinate2D(latitude: 47.143438, longitude: 8.432863)
        pointHSLU.title = "HSLU"
        pointHSLU.subtitle = "Hochschule Luzern - Informatik"
        annotations.append(pointHSLU)
        
        // Rotkreuz point annotiation
        let pointRotkreuz = MKPointAnnotation()
        pointRotkreuz.coordinate = CLLocationCoordinate2D(latitude: 47.141884, longitude: 8.430481)
        pointRotkreuz.title = "Rotkreuz"
        pointRotkreuz.subtitle = "Bahnhof"
        annotations.append(pointRotkreuz)
        
        mapView.addAnnotations(annotations)

        // zoom to defined annotations
        fitMapViewToAnnotaionList(annotations: annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        
        // define MKAnnotationView which will be returned at the end
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
          
        annotationView?.canShowCallout = true
        
        if(annotation.title == "Rotkreuz") {
            
            // create MKPinAnnotationView from MKAnnotation
            // needs to be done to be able to set pinTintColor
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pin.pinTintColor = .green
            
            // refer changed MKPinAnnotationView to MKAnnotationView
            annotationView = pin
        }
        
        if(annotation.title == "HSLU") {
            
            // create MKPinAnnotationView from MKAnnotation
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            let pinImage = UIImage(named: "hslu.jpg")
            
            // define size of hslu image
            let size = CGSize(width: 50, height: 50)
            
            // somehow this is needed
            UIGraphicsBeginImageContext(size)
            
            // resize image object
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            // apply image to resized object
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            annotationView?.image = resizedImage
            
            // create info button in callout
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        }
        
        // allow callout
        // needs to be somehow at the end!
        annotationView?.canShowCallout = true

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // popup alert
        let ac = UIAlertController(title: "General information", message: "Swift is a shitty place", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "I know", style: .default))
        present(ac, animated: true)
    }
    
    func fitMapViewToAnnotaionList(annotations: [MKPointAnnotation]) -> Void {
        let mapEdgePadding = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
        var zoomRect:MKMapRect = MKMapRect.null

        for index in 0..<annotations.count {
            let annotation = annotations[index]
            let aPoint : MKMapPoint = MKMapPoint(annotation.coordinate)
            let rect : MKMapRect = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)

            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }

        self.mapView.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
    }
    
    @IBAction func editEventButtonPressed(_ sender: Any) {
        
        // authorize app to access calendar
        // IMPORTANT:
        // add key "Privacy - Calendars Usage Description" to Info.plist with custom value
        switch EKEventStore.authorizationStatus(for: .event) {
                case .notDetermined:
                    let eventStore = EKEventStore()
                    eventStore.requestAccess(to: .event) { (granted, error) in
                        if granted {
                            // watch out this is running in background
                            DispatchQueue.main.async {
                                self.openEventController()
                            }
                        }
                    }
                case .authorized:
                    
                    // watch out this is running in background
                    DispatchQueue.main.async {
                        self.openEventController()
                    }
                default:
                    break
        }
    }
    
    func openEventController() {
        
        let eventVC = EKEventEditViewController()
        eventVC.editViewDelegate = self
        eventVC.eventStore = EKEventStore()
        
        let predicate = eventVC.eventStore.predicateForEvents(withStart: Date(), end: Date.distantFuture, calendars: nil)
        let events = eventVC.eventStore.events(matching: predicate)
        eventVC.event = events[0]
        
        self.present(eventVC, animated: true)
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        dismiss(animated: true) {
            print("do something with entered calendar entry")
        }
    }
}

