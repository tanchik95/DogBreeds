//
//  DogBreedsViewController.swift
//
//  Created by Tatyana Anikina on 25.01.2021.
//

import UIKit

protocol DogBreedsDisplayLogic: AnyObject {
    func displayItems(viewModel: DogBreeds.DogBreedsList.ViewModel)
}

protocol DogBreedsViewControllerDelegate: AnyObject {
    func openDogBreedsDetails(_ dogBreedsId: UniqueIdentifier)
}

final class DogBreedsViewController: UIViewController {
    let interactor: DogBreedsBusinessLogic
    let router: DogBreedsNavigationLogic
    var state: DogBreeds.ViewControllerState

    var tableDataSource: DogBreedsTableDataSource = .init()
    var tableDelegate: DogBreedsTableDelegate = .init()

    private lazy var customView = self.view as? DogBreedsView

    // MARK: - Init

    init(title: String,
         interactor: DogBreedsBusinessLogic,
         router: DogBreedsNavigationLogic,
         initialState: DogBreeds.ViewControllerState = .loadingAll) {
        self.interactor = interactor
        self.router = router
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
        tableDelegate.delegate = self
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = DogBreedsView(
            frame: UIScreen.main.bounds,
            switchDelegate: self
        )
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        display(newState: state)
    }

    // MARK: - Private Methods

    private func fetchItems(isFavoriteOnly: Bool) {
        let request = DogBreeds.DogBreedsList.Request(isFavorite: isFavoriteOnly)
        interactor.fetchItems(request: request)
    }
}

// MARK:  DogBreedsDisplayLogic

extension DogBreedsViewController: DogBreedsDisplayLogic {
    func displayItems(viewModel: DogBreeds.DogBreedsList.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: DogBreeds.ViewControllerState) {
        state = newState
        switch state {
        case .loadingAll:
            fetchItems(isFavoriteOnly: false)
        case .loadingFavorites:
            fetchItems(isFavoriteOnly: true)
        case let .result(items):
            tableDelegate.representableViewModels = items
            tableDataSource.representableViewModels = items
            customView?.updateTableViewData(delegate: tableDelegate, dataSource: tableDataSource)
        case let .error(message):
            customView?.showError(message: message)
        }
    }
}

// MARK: DogBreedsViewControllerDelegate

extension DogBreedsViewController: DogBreedsViewControllerDelegate {
    func openDogBreedsDetails(_ DogBreedsId: UniqueIdentifier) {
        router.pushDogBreedsDetailsModule(withId: DogBreedsId)
    }
}

// MARK: DogBreedsPreferencesViewDelegate

extension DogBreedsViewController: DogBreedsPreferencesViewDelegate {
    func switchValueChanged(_ isOn: Bool) {
        if isOn {
            display(newState: .loadingFavorites)
        } else {
            display(newState: .loadingAll)
        }
    }
}


