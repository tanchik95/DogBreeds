//
//  DogBreedsView.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//

import SnapKit
import UIKit

final class DogBreedsView: UIView {
    struct ViewMetrics {
        let spinnerColor: UIColor = .black
        let backgroundColor: UIColor = .white
        let tableBackgroundColor: UIColor = .white
    }

    var viewMetrics = ViewMetrics()

    weak var switchActionsDelegate: DogBreedsPreferencesViewDelegate?

    // MARK: - View Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    private lazy var headerView: DogBreedsPreferencesView = {
        let view = DogBreedsPreferencesView()
        view.delegate = switchActionsDelegate
        return view
    }()

    private lazy var errorView: DogBreedsErrorView = .init()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.color = viewMetrics.spinnerColor
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: - Init

    init(frame: CGRect,
         switchDelegate: DogBreedsPreferencesViewDelegate,
         viewMetrics: ViewMetrics = .init()) {
        super.init(frame: frame)

        switchActionsDelegate = switchDelegate
        backgroundColor = viewMetrics.backgroundColor
        configureTableView()
        addSubview(headerView)
        addSubview(tableView)
        addSubview(errorView)
        addSubview(spinner)
//        addSubviews(
//            headerView,
//            tableView,
//            errorView,
//            spinner
//        )
        configureLayout()
        [tableView, errorView, spinner].forEach { $0.isHidden = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTableView() {
        tableView.backgroundColor = viewMetrics.tableBackgroundColor
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }

    private func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        [tableView, errorView].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalTo(headerView.snp.bottom)
                make.trailing.leading.bottom.equalToSuperview()
            }
        }
    }

    // MARK: - Private Methods

    private func show(view: UIView) {
        subviews.forEach {
            $0.isHidden = (view != $0 && $0 != headerView)
        }
    }

    // MARK: - States

    func showLoading() {
        show(view: spinner)
    }

    func showError(message: String) {
        show(view: errorView)
        errorView.configure(withMessage: message)
    }

    func showTable() {
        show(view: tableView)
    }

    func updateTableViewData(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        showTable()
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.reloadData()
    }
}

