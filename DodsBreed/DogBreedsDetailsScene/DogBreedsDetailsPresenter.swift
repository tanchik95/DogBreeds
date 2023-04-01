//
//  DogBreedsDetailsPresenter.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import UIKit.UIImage

protocol DogBreedsDetailsPresentationLogic {
    func presentItem(response: DogBreedsDetails.ShowItem.Response)
}

final class DogBreedsDetailsPresenter {
    weak var viewController: DogBreedsDetailsDisplayLogic?
    let errorMessage = "Error loading data 💩"
}

extension DogBreedsDetailsPresenter: DogBreedsDetailsPresentationLogic {
    func presentItem(response: DogBreedsDetails.ShowItem.Response) {
        var viewModel: DogBreedsDetails.ShowItem.ViewModel

        switch response.result {
        case let .success(result):
            let DogBreeds: DogBreedsDetailsViewModel = .init(
                uid: result.uid,
                name: result.breed,
                origin: result.origin,
                state: result.state,
                coordinates: result.coordinates,
                image: UIImage(named: result.imageName),
                isFavorite: result.isFavorite
            )
            viewModel = .init(state: .result(DogBreeds))
        case .failure:
            viewModel = .init(state: .error(message: errorMessage))
        }
        viewController?.displayItem(viewModel: viewModel)
    }
}
