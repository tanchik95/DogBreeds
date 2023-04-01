//
//  DogBreedsDataStore.swift
//
//  Created by Татьяна Аникина on 06.02.2023.
//

import Foundation

protocol DogBreedsDataStoreProtocol: AnyObject {
    var models: [DogBreedsModel]? { get set }
}

final class DogBreedsDataStore: DogBreedsDataStoreProtocol {
    static let shared = DogBreedsDataStore()
    var models: [DogBreedsModel]?
}
