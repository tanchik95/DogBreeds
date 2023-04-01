//
//  DogBreedsErrorView.swift
//
//  Created by Татьяна Аникина on 31.03.2023.
//

import SnapKit
import UIKit

final class DogBreedsErrorView: UIView {
    final class Appearance {
        let titleColor: UIColor =  .black
        let backgroundColor: UIColor =  .white
        let titleInsets = UIEdgeInsets(top: 0.35, left: 33, bottom: 0, right: 32)
    }

    let appearance: Appearance

    // MARK: - View Properties

    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = appearance.titleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: - Init

    init(appearance: Appearance = Appearance()) {
        self.appearance = appearance
        super.init(frame: CGRect.zero)
        
        backgroundColor = appearance.backgroundColor
        addSubview(title)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(appearance.titleInsets.left)
            make.trailing.equalToSuperview().inset(appearance.titleInsets.right)
        }
    }

    // MARK: Configuration

    func configure(withMessage errorMessage: String) {
        title.text = errorMessage
    }
}

