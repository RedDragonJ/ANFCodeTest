//
//  ExploreItem.swift
//  ANF Code Test
//
//  Created by James Layton on 1/16/25.
//

import Foundation

struct ExploreItem: Codable {
    let title: String?
    let backgroundImage: URL?
    let content: [ContentItem]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?

    init(
        title: String?,
        backgroundImage: URL?,
        content: [ContentItem]?,
        promoMessage: String?,
        topDescription: String?,
        bottomDescription: String?
    ) {
        self.title = title
        self.backgroundImage = backgroundImage
        self.content = content
        self.promoMessage = promoMessage
        self.topDescription = topDescription
        self.bottomDescription = bottomDescription
    }

    enum CodingKeys: String, CodingKey {
        case title
        case backgroundImage
        case content
        case promoMessage
        case topDescription
        case bottomDescription
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode all other properties as usual
        title = try container.decodeIfPresent(String.self, forKey: .title)
        promoMessage = try container.decodeIfPresent(String.self, forKey: .promoMessage)
        topDescription = try container.decodeIfPresent(String.self, forKey: .topDescription)
        bottomDescription = try container.decodeIfPresent(String.self, forKey: .bottomDescription)
        content = try container.decodeIfPresent([ContentItem].self, forKey: .content)

        // Replace "http" with "https" for the backgroundImage so we don't change App Transport Security policy with AllowsArbitraryLoads
        if let backgroundImageString = try container.decodeIfPresent(String.self, forKey: .backgroundImage) {
            backgroundImage = URL(string: backgroundImageString.replacingOccurrences(of: "http://", with: "https://"))
        } else {
            backgroundImage = nil
        }
    }
}

struct ContentItem: Codable {
    let elementType: String?
    let target: URL?
    let title: String?

    init(elementType: String?, target: URL?, title: String?) {
        self.elementType = elementType
        self.target = target
        self.title = title
    }

    enum CodingKeys: String, CodingKey {
        case elementType
        case target
        case title
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode all other properties as usual
        elementType = try container.decodeIfPresent(String.self, forKey: .elementType)
        title = try container.decodeIfPresent(String.self, forKey: .title)

        // Replace "http" with "https" for the target URL so we don't change App Transport Security policy with AllowsArbitraryLoads
        if let targetString = try container.decodeIfPresent(String.self, forKey: .target) {
            target = URL(string: targetString.replacingOccurrences(of: "http://", with: "https://"))
        } else {
            target = nil
        }
    }
}
