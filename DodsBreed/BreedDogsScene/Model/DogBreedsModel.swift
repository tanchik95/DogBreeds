//
//  DogBreedsModel.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//

import Foundation

typealias DogBreedsResponse = [DogBreedsModel]
    
    struct DogBreedsModel: UniqueIdentifiable, Decodable {
        let uid: UniqueIdentifier
        let breed: String
        let state: String
        let origin: String
        let coordinates: Coordinates
        let imageName: String
        let isFavorite: Bool
        
        enum CodingKeys: String, CodingKey {
            case uid = "id"
            case breed
            case state
            case origin
            case coordinates
            case imageName
            case isFavorite
    }
}

    struct Coordinates: Decodable {
        let longitude: Double
        let latitude: Double
    }

