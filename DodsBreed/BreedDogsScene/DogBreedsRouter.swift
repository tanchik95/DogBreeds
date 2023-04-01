//
//  DogBreedsRouter.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import UIKit

protocol DogBreedsNavigationLogic {
    func pushDogBreedsDetailsModule(withId DogBreedsId: UniqueIdentifier)
}

final class DogBreedsRouter {
    weak var viewController: DogBreedsViewController?
}

// MARK: - Business Logic

extension DogBreedsRouter: DogBreedsNavigationLogic {
    func pushDogBreedsDetailsModule(withId DogBreedsId: UniqueIdentifier) {
        let detailsController = DogBreedsDetailsBuilder()
            .set(initialState: .initial(id: DogBreedsId))
            .build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
