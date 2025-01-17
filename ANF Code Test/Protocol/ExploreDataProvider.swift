//
//  ExploreDataProvider.swift
//  ANF Code Test
//
//  Created by James Layton on 1/17/25.
//

import Foundation

protocol ExploreDataProvider {
    func fetchData(completion: @escaping (Result<[ExploreItem], Error>) -> Void)
}
