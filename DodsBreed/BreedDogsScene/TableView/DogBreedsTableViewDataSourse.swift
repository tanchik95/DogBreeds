//
//  DogBreedsTableViewDataSourse.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//


import UIKit

final class DogBreedsTableDataSource: NSObject, UITableViewDataSource {
    var representableViewModels: [DogBreedsViewModel]

    init(viewModels: [DogBreedsViewModel] = []) {
        representableViewModels = viewModels
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        representableViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithRegistration(type: DogBreedsCell.self, indexPath: indexPath)
        guard let viewModel = representableViewModels[safe: indexPath.row] else { return cell }
        cell.configure(cellRepresentable: viewModel)
        return cell
    }
}
