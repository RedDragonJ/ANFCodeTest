//
//  ExploreItem.swift
//  ANF Code Test
//
//  Created by James Layton on 1/16/25.
//

import Foundation

struct ExploreItem: Codable {
    let title: String?
    let backgroundImage: String?
    let content: [ContentItem]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
}

struct ContentItem: Codable {
    let elementType: String?
    let target: URL?
    let title: String?
}
