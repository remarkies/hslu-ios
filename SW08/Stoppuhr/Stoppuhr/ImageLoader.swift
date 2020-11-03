//
//  ImageLoader.swift
//  Stoppuhr
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

final class ImageLoader: View, ObservableObject {
    
    @Published var image: UIImage?
    
    init() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://static.independent.co.uk/s3fs-public/thumbnails/image/2020/02/08/12/Trump-face.jpg")!, completionHandler:  {
            (data, response, error) in
            
            if let error = error {
                print("Loading image failed, \(error)")
                
                self.image = nil
            }
            else if let data = data {
                print("Loading image succeded")
                self.image = UIImage(data: data)
            }
        })
        task.resume()
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader()
    }
}
