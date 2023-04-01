//
//  DogBreedsCell.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//

import SnapKit
import UIKit

final class DogBreedsCell: UITableViewCell {
    struct ViewMetrics {
        let backgroundColor: UIColor = .white

        let iconImageSide: CGFloat = 50
        let iconImageInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 10)

        let labelTextColor: UIColor = .black
        let labelInsets = UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 5)
        let labelFontSize: CGFloat = 15

        let starImageSide: CGFloat = 15
        let starImageInsets = UIEdgeInsets(top: 25, left: 5, bottom: 25, right: 12)
        let starImageColor = UIColor.orange

        let detailsImageSide: CGFloat = 15
        let detailsImageInset: CGFloat = 20

        let separatorHeight: CGFloat = 1
        let separatorOffset: CGFloat = 12
        let separatorColor = UIColor(red: 11/255, green: 31/255, blue: 53/255, alpha: 0.05)
    }

    let viewMetrics = ViewMetrics()

    // MARK: - View Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = self.viewMetrics.labelTextColor
        label.font = .systemFont(ofSize: viewMetrics.labelFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.setRadius(radius: viewMetrics.iconImageSide / 2)
        return view
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "star.fill"))
        view.tintColor = viewMetrics.starImageColor
        return view
    }()
    
    private lazy var detailsImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "chevron.right"))
        view.tintColor = .gray
        return view
    }()

    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = self.viewMetrics.separatorColor
        return view
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = viewMetrics.backgroundColor
        
        addSubview(contentView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(detailsImageView)
        contentView.addSubview(separator)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(viewMetrics.iconImageInsets)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(viewMetrics.iconImageSide)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(viewMetrics.iconImageInsets.right)
            make.top.bottom.equalToSuperview().inset(viewMetrics.labelInsets.top)
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(viewMetrics.starImageInsets.left)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(viewMetrics.starImageSide)
        }
        detailsImageView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(starImageView.snp.trailing).offset(viewMetrics.starImageInsets.right)
            make.trailing.equalToSuperview().inset(viewMetrics.detailsImageInset)
            make.centerY.equalToSuperview()
        }
        separator.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(viewMetrics.separatorOffset)
            make.height.equalTo(viewMetrics.separatorHeight)
        }
    }

    // MARK: Public Methods

    func configure(cellRepresentable: DogBreedsViewModel) {
        titleLabel.text = cellRepresentable.title
        iconImageView.image = cellRepresentable.image
        starImageView.isHidden = !cellRepresentable.isFavorite
    }
}

