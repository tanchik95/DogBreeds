//
//  DogBreedsDetailsInteractor.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

protocol DogBreedsDetailsBusinessLogic {
    func fetchItemDetails(request: DogBreedsDetails.ShowItem.Request)
}

final class DogBreedsDetailsInteractor {
    let presenter: DogBreedsDetailsPresentationLogic
    let provider: DogBreedsDetailsProviderProtocol

    // MARK: - Init

    init(presenter: DogBreedsDetailsPresentationLogic, provider: DogBreedsDetailsProviderProtocol = DogBreedsDetailsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
}

// MARK: - Business Logic

extension DogBreedsDetailsInteractor: DogBreedsDetailsBusinessLogic {
    func fetchItemDetails(request: DogBreedsDetails.ShowItem.Request) {
        provider.getItem(withId: request.uid) { (item, error) in
            let result: Result<DogBreedsModel>
            if let item = item {
                result = .success(item)
            } else {
                result = .failure(DogBreedsDetails.ShowItem.Response.Error.someError)
            }
            self.presenter.presentItem(response: .init(result: result))
        }
    }
}
