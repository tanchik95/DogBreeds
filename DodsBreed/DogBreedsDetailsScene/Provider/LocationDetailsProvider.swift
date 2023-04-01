//
//  DogBreedsDetailsProvider.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//


import Foundation

protocol DogBreedsDetailsProviderProtocol {
    func getItem(withId id: UniqueIdentifier, completion: @escaping (DogBreedsModel?, DogBreedsDetailsProviderError?) -> Void)
}

enum DogBreedsDetailsProviderError: Error {
    case getItemFailed(withError: Error)

    var associatedValue: Error {
        switch self {
        case .getItemFailed(let withError):
            return withError
        }
    }
}

struct DogBreedsDetailsProvider {
    let dataStore: DogBreedsDataStoreProtocol

    // MARK: - Init

    init(dataStore: DogBreedsDataStoreProtocol = DogBreedsDataStore.shared) {
        self.dataStore = dataStore
    }
}

// MARK: - DogBreedsDetailsProviderProtocol

extension DogBreedsDetailsProvider: DogBreedsDetailsProviderProtocol {
    func getItem(withId id: UniqueIdentifier, completion: @escaping (DogBreedsModel?, DogBreedsDetailsProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            let model = dataStore.models?.first(where: { $0.uid == id })
            return completion(model, nil)
        }
        return completion(nil, nil)
    }
}
