//
//  DogBreedsDetailsViewModel.swift
//
//  Created by Татьяна Аникина on 22.12.2022.
//

import UIKit

struct DogBreedsDetailsViewModel {
    let uid: UniqueIdentifier
    let name: String
    let origin: String
    let state: String
    let coordinates: Coordinates
    let image: UIImage?
    let isFavorite: Bool
}
