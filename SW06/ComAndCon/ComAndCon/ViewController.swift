//
//  ViewController.swift
//  ComAndCon
//
//  Created by Luka Kramer on 26.10.20.
//

import UIKit
import Vision

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detectionLabel: UILabel!
    
    var images: [ImageInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        imageView.contentMode = .scaleAspectFill
        
        if let res = loadListSync() {
            self.images = res
            pickerView(picker, didSelectRow: 0, inComponent: 1)
            
        } else {
            print("No images found")
        }
        
    }
    
    func loadListSync() -> [ImageInfo]? {
        let session = URLSession(configuration: .default)
        
        let url = URL(string: "https://hslu.nitschi.ch/networking/data.json")!
        var list: [ImageInfo] = []
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                print("Data Task failed, error: \(error)")
            }
            else if let data = data {
                do {
                    let model = try JSONDecoder().decode(Response.self, from: data)
                    list = model.images
                    semaphore.signal()
                    
                } catch let error {
                    print("JSONDecoder failed, \(error)")
                }
                
            }
        })
        
        task.resume()
        semaphore.wait()
        
        return list
    }
    
    func loadImageSync(image: ImageInfo) -> UIImage? {

        let session = URLSession(configuration: .default)
        var result: UIImage? = nil
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: image.url, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                print("Loading \(image.title) failed, \(error)")
            }
            else if let data = data {
                result = UIImage(data: data)
                semaphore.signal()
            }
        })
        
        task.resume()
        semaphore.wait()
        
        return result
    }
    
    func loadImageAsync(image: ImageInfo, completion: @escaping (UIImage?)->Void) {
        URLSession.shared.dataTask(with: image.url, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    print("Loading \(image.title) failed, \(error)")
                    completion(nil)
                }
                return
            }
            else if let data = data {
                DispatchQueue.main.async {
                    let res = UIImage(data: data)
                    completion(res)
                }
            }
        }).resume()
    }
    
    func classifyImageAsync(image: UIImage?, completion: @escaping (String?)->Void) {
        DispatchQueue.global().async {
        
            guard let cgImage = image?.cgImage else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
            
        // create a image request handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // perform a classify-request
        try? handler.perform([VNClassifyImageRequest(completionHandler: { (request, error) in
        
            let topResults = request.results?.compactMap { $0 as? VNClassificationObservation }
                .filter { $0.confidence > 0.8 } // 2
                .map { $0.identifier } // 3
                .joined(separator: ", ") // 4
                DispatchQueue.main.async {
                    completion(topResults)
                }
                
            }
        )])
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return images[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectImage(newImage: images[row])
    }
    
    func selectImage(newImage: ImageInfo) {
        titleLabel.text = newImage.text
        
        loadImageAsync(image: newImage, completion: { (image) in
            self.imageView.image = image
            
            self.classifyImageAsync(image: image, completion: {
                (res) in
                self.detectionLabel.text = res
            })
        })
    }

}

