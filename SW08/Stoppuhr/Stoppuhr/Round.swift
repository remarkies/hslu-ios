//
//  Round.swift
//  Stoppuhr
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI
import Foundation

struct Round: View {
    let globalStart: Date
    let lapStart: Date
    
    var durationString: String {
        let diff = Calendar.current.dateComponents([.second], from: globalStart, to: lapStart)
        if diff.second != nil {
            return "\(String(diff.second!)) sec"
        }
        return ""
        
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(durationString)
                Text(lapStart, style: .time)
            }
            Spacer()
            Image(systemName: "timer").font(.system(size: 16, weight: .regular)).padding()
            
        }
    }
}

struct Round_Previews: PreviewProvider {
    static var previews: some View {
        Round(globalStart: Date(), lapStart: Date().addingTimeInterval(2))
    }
}
