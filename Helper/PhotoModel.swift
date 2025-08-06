//
//  PhotoModel.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let urls: PhotoURLs
}

struct PhotoURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
