//
//  DogBreedsPreferencesView.swift

//
//  Created by Татьяна Аникина on 31.03.2023.
//

import UIKit

protocol DogBreedsPreferencesViewDelegate: AnyObject {
    func switchValueChanged(_ isOn: Bool)
}

final class DogBreedsPreferencesView: UIView {
    struct ViewMetrics {
        let labelFontSize: CGFloat = 15
        let labelInsets = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 12)

        let switchTrailingInset: CGFloat = 20

        let separatorHeight: CGFloat = 1
        let separatorColor = UIColor(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.05)
    }

    let viewMetrics: ViewMetrics
    weak var delegate: DogBreedsPreferencesViewDelegate?

    // MARK: - View Properties

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Любимые породы"
        label.textColor = .black
        label.font = .systemFont(ofSize: viewMetrics.labelFontSize)
        label.textAlignment = .left
        return label
    }()

    private lazy var favoritesOnlySwitch: UISwitch = {
        let favoritesOnlySwitch = UISwitch()
        favoritesOnlySwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return favoritesOnlySwitch
    }()

    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = self.viewMetrics.separatorColor
        return view
    }()

    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = self.viewMetrics.separatorColor
        return view
    }()

    // MARK: - Init
    
    init(viewMetrics: ViewMetrics = ViewMetrics()) {
        self.viewMetrics = viewMetrics
        super.init(frame: .zero)

        addSubviews(
            topSeparator,
            title,
            favoritesOnlySwitch,
            bottomSeparator
        )
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        topSeparator.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.leading.equalTo(title)
            make.height.equalTo(viewMetrics.separatorHeight)
        }
        title.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(viewMetrics.labelInsets.top)
            make.leading.equalToSuperview().inset(viewMetrics.labelInsets.left)
        }
        favoritesOnlySwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(viewMetrics.switchTrailingInset)
            make.centerY.equalToSuperview()
        }
        bottomSeparator.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalTo(title)
            make.height.equalTo(viewMetrics.separatorHeight)
        }
    }

    // MARK: - View Actions 

    @objc private func switchValueChanged() {
        delegate?.switchValueChanged(favoritesOnlySwitch.isOn)
    }
}
