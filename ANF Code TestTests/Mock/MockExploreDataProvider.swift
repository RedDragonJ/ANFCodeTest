//
//  MockExploreDataProvider.swift
//  ANF Code Test
//
//  Created by James Layton on 1/17/25.
//

import Foundation

class MockExploreDataProvider: ExploreDataProvider {
    func fetchData(completion: @escaping (Result<[ExploreItem], Error>) -> Void) {
        let mockData = [
            ExploreItem(
                title: "Test Title 1",
                backgroundImage: URL(string: "https://img.abercrombie.com/is/image/anf/ANF-2024-060624-M-HP-NewArrivals-USCA-Mens.jpg")!,
                content: [
                    ContentItem(elementType: "button", target: URL(string: "https://example.com/1"), title: "Learn More")
                ],
                promoMessage: "Promo 1",
                topDescription: "Top Description 1",
                bottomDescription: "Bottom Description 1"
            ),
            ExploreItem(
                title: "Test Title 2",
                backgroundImage: URL(string: "https://img.abercrombie.com/is/image/anf/ANF-2024-060624-M-HP-NewArrivals-USCA-Mens.jpg")!,
                content: [
                    ContentItem(elementType: "button", target: URL(string: "https://example.com/2"), title: "Shop Now"),
                    ContentItem(elementType: "link", target: URL(string: "https://example.com/3"), title: "View Details")
                ],
                promoMessage: "Promo 2",
                topDescription: "Top Description 2",
                bottomDescription: "Bottom Description 2"
            )
        ]
        completion(.success(mockData))
    }
}

