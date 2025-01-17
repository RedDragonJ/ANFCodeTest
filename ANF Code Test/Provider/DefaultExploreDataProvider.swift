//
//  DefaultExploreDataProvider.swift
//  ANF Code Test
//
//  Created by James Layton on 1/17/25.
//

import Foundation

class DefaultExploreDataProvider: ExploreDataProvider {
    func fetchData(completion: @escaping (Result<[ExploreItem], Error>) -> Void) {
        guard let url = URL(string: K.API.endpoint) else {
            let invalidURLError = NSError(domain: K.InvalidState.domain,
                                          code: K.InvalidState.code,
                                          userInfo: [NSLocalizedDescriptionKey: K.InvalidState.url])
            completion(.failure(invalidURLError))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: K.InvalidState.domain,
                                          code: K.InvalidState.code,
                                          userInfo: [NSLocalizedDescriptionKey: K.InvalidState.noData])
                completion(.failure(noDataError))
                return
            }

            do {
                let items = try JSONDecoder().decode([ExploreItem].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
