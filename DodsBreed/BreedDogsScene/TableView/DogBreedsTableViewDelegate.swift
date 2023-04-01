//
//  DogBreedsTableViewDelegate.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//

import UIKit

final class DogBreedsTableDelegate: NSObject, UITableViewDelegate {
    weak var delegate: DogBreedsViewControllerDelegate?
    var representableViewModels: [DogBreedsViewModel]

    init(viewModels: [DogBreedsViewModel] = []) {
        representableViewModels = viewModels
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let viewModel = representableViewModels[safe: indexPath.row] else {
            return
        }
        delegate?.openDogBreedsDetails(viewModel.uid)
    }
}

