//
//  DogBreedsBuilder.swift
//
//  Created by Татьяна Аникина on 04.09.2022.
//


import UIKit

final class DogBreedsBuilder: ModuleBuilder {
    var title: String?

    func setTitle(_ title: String) -> Self {
        self.title = title
        return self
    }

    func build() -> UIViewController {
        guard let title = title else {
            fatalError("You should set a title")
        }
        let presenter = DogBreedsPresenter()
        let interactor = DogBreedsInteractor(presenter: presenter)
        let router = DogBreedsRouter()
        let controller = DogBreedsViewController(
            title: title,
            interactor: interactor,
            router: router,
            initialState: .loadingAll
        )
        router.viewController = controller
        presenter.viewController = controller
        return controller
    }
}
