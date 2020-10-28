//
//  Response.swift
//  ComAndCon
//
//  Created by Luka Kramer on 26.10.20.
//

import Foundation

struct Response: Codable {
    let images: [ImageInfo]
    let lastUpdate: Date
    let info: String
}
