//
// DogBreedsDetailsBuilder.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import UIKit

final class DogBreedsDetailsBuilder: ModuleBuilder {
    var initialState: DogBreedsDetails.ViewControllerState?

    func set(initialState: DogBreedsDetails.ViewControllerState) -> Self {
        self.initialState = initialState
        return self
    }

    func build() -> UIViewController {
        guard let initialState = initialState else {
            fatalError("Initial state parameter was not set")
        }
        let presenter = DogBreedsDetailsPresenter()
        let interactor = DogBreedsDetailsInteractor(presenter: presenter)
        let controller = DogBreedsDetailsViewController(
            interactor: interactor,
            initialState: initialState
        )
        presenter.viewController = controller
        return controller
    }
}
