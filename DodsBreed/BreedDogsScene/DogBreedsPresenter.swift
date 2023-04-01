//
//  DogBreedsPresenter.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//


import UIKit.UIImage

protocol  DogBreedsPresentationLogic {
    func presentItems(response: DogBreeds.DogBreedsList.Response)
}

final class DogBreedsPresenter {
    weak var viewController: DogBreedsDisplayLogic?

    // MARK: - Private Methods

    private func viewModels(from models: [DogBreedsModel]) -> [DogBreedsViewModel] {
        var viewModels = [DogBreedsViewModel]()
        models.forEach { model in
            let viewModel = DogBreedsViewModel(
                uid: model.uid,
                title: model.breed,
                image: UIImage(named: model.imageName),
                isFavorite: model.isFavorite
            )
            viewModels.append(viewModel)
        }
        return viewModels
    }
}

// MARK: - Business Logic

extension DogBreedsPresenter: DogBreedsPresentationLogic {
    func presentItems(response: DogBreeds.DogBreedsList.Response) {
        var viewModel: DogBreeds.DogBreedsList.ViewModel

        switch response.result {
        case let .success(result):
            let DogBreeds = viewModels(from: result)
            viewModel = .init(state: .result(DogBreeds))
        case let .failure(error):
            viewModel = .init(state: .error(message: error.localizedDescription))
        }
        viewController?.displayItems(viewModel: viewModel)
    }
}

