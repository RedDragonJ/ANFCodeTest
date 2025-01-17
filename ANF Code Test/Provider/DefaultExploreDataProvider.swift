//
//  DefaultExploreDataProvider.swift
//  ANF Code Test
//
//  Created by James Layton on 1/17/25.
//

import Foundation

class DefaultExploreDataProvider: ExploreDataProvider {
    func fetchData() -> [ExploreItem] {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let jsonDictionary = try? JSONDecoder().decode([ExploreItem].self, from: fileContent) {
            return jsonDictionary
        }
        return []
    }
}
