//
//  ContentView.swift
//  Stoppuhr
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct ContentView: View {
    @State var start = Date()
    @State var laps: [Date] = []
    @State var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            Form {
                Section {
                    List {
                        Button("Reset") {
                            self.start = Date()
                            self.laps = []
                        }
                        Button("Lap") {
                            self.laps.append(Date())
                        }
                    }
                }
                Section {
                    Text("\(self.laps.count) lap(s)")
                    List {
                        ForEach(self.laps, id: \.self) { lap in
                            Round(globalStart: self.start, lapStart: lap)
                        }
                    }
                }
                Section {
                    if let img = imageLoader.image {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
