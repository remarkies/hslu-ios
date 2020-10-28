//
//  ImageInfo.swift
//  ComAndCon
//
//  Created by Luka Kramer on 26.10.20.
//

import Foundation

struct ImageInfo: Codable {
    let identifier: Int
    let title: String
    let text: String
    let url: URL
}
