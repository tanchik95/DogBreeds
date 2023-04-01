//
//  DogBreedsDetailsViewController.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import UIKit

protocol DogBreedsDetailsDisplayLogic: AnyObject {
    func displayItem(viewModel: DogBreedsDetails.ShowItem.ViewModel)
}

final class DogBreedsDetailsViewController: UIViewController {
    let interactor: DogBreedsDetailsBusinessLogic
    var state: DogBreedsDetails.ViewControllerState

    private lazy var dogBreedsDetailsView = self.view as? DogBreedsDetailsView

    // MARK: - Init

    init(interactor: DogBreedsDetailsBusinessLogic, initialState: DogBreedsDetails.ViewControllerState) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = DogBreedsDetailsView(frame: UIScreen.main.bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        display(newState: state)
    }

    // MARK: - Private Methods

    private func fetchDetailsForItem(withId uuid: UniqueIdentifier) {
        let request = DogBreedsDetails.ShowItem.Request(uid: uuid)
        interactor.fetchItemDetails(request: request)
    }
}

// MARK: - Business Logic

extension DogBreedsDetailsViewController: DogBreedsDetailsDisplayLogic {
    func displayItem(viewModel: DogBreedsDetails.ShowItem.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: DogBreedsDetails.ViewControllerState) {
        switch newState {
        case .loading:
            dogBreedsDetailsView?.showLoading()
        case let .result(model):
            title = model.name
            dogBreedsDetailsView?.showView()
            dogBreedsDetailsView?.configure(with: model)
        case let .error(message: errorMessage):
            print("error, message: \(errorMessage)")
        case .initial(id: let id):
            dogBreedsDetailsView?.showLoading()
            fetchDetailsForItem(withId: id)
        }
    }
}

