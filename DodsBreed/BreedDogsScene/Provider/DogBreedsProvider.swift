//
//  DogBreedsProvider.swift
//
//  Created by Татьяна Аникина on 14.10.2022.
//


import Foundation

protocol DogBreedsProviderProtocol {
    func getItems(completion: @escaping ([DogBreedsModel]?, DogBreedsProviderError?) -> Void)
}

enum DogBreedsProviderError: Error {
    case getItemsFailed(withError: Error)

    var associatedValue: Error {
        switch self {
        case .getItemsFailed(let withError):
            return withError
        }
    }
}

struct DogBreedsProvider {
    let dataStore: DogBreedsDataStoreProtocol
    let service: DogBreedsServiceProtocol

    // MARK: Lifecycle

    init(dataStore: DogBreedsDataStoreProtocol = DogBreedsDataStore.shared, service: DogBreedsServiceProtocol = DogBreedsService()) {
        self.dataStore = dataStore
        self.service = service
    }
}

// MARK: DogBreedsProviderProtocol

extension DogBreedsProvider: DogBreedsProviderProtocol {
    func getItems(completion: @escaping ([DogBreedsModel]?, DogBreedsProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            return completion(self.dataStore.models, nil)
        }
        service.fetchItems { (models, error) in
            if let error = error {
                completion(nil, .getItemsFailed(withError: error))
            } else if let models = models {
                self.dataStore.models = models
                completion(self.dataStore.models, nil)
            }
        }
    }
}
