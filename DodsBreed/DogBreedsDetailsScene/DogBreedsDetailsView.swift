//
//  DogBreedsDetailsView.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import MapKit
import SnapKit
import UIKit

final class DogBreedsDetailsView: UIView {
    struct ViewMetrics {
        let backgroundColor: UIColor = .white

        let mapViewHeight: CGFloat = UIScreen.main.bounds.height * 5 / 13
        let mapScale: CGFloat = 2500

        let iconImageSide: CGFloat = 200
        let iconBorderWidth: CGFloat = 5.0
        let iconBorderColor: UIColor = .white

        let labelsHorizontalInset: CGFloat = 20
        let nameLabelTopOffset: CGFloat = 10
        let subtitleLabelTopOffset: CGFloat = 5
        let defaultTextColor: UIColor = .black
        let titleFontSize: CGFloat = 20
        let originFontSize: CGFloat = 18
        let subtitleFontSize: CGFloat = 15

        let starImageColor = UIColor(red: 255/255, green: 202/255, blue: 2/255, alpha: 1)
        let starImageInsets = UIEdgeInsets(top: 25, left: 5, bottom: 25, right: 12)
        let subtitleLabelsOffset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        let stateLabelOffset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 0.0, right: 0.0)
        let originLabelOffset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 0.0, right: 0.0)
        let starImageSide: CGFloat = 15
       

        let spinnerColor: UIColor = .black
    }

    var viewMetrics = ViewMetrics()

    // MARK: - View Properties

    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var iconImageBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderColor = viewMetrics.iconBorderColor.cgColor
        view.layer.borderWidth = viewMetrics.iconBorderWidth
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = self.viewMetrics.defaultTextColor
        label.font = .systemFont(ofSize: viewMetrics.titleFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var starImageView: UIImageView = {
        let view = UIImageView(image: .init(systemName: "star.fill"))
        view.tintColor = viewMetrics.starImageColor
        return view
    }()

    private lazy var originLabel: UILabel = {
        let label = UILabel()
        label.textColor = viewMetrics.defaultTextColor
        label.font = .systemFont(ofSize: viewMetrics.originFontSize)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.textColor = viewMetrics.defaultTextColor
        label.font = .systemFont(ofSize: viewMetrics.subtitleFontSize)
        label.numberOfLines = 0
        return label
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.color = viewMetrics.spinnerColor
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: - Init

    init(frame: CGRect, viewMetrics: ViewMetrics = .init()) {
        super.init(frame: frame)

        backgroundColor = viewMetrics.backgroundColor
        iconImageBGView.addSubview(iconImageView)
        
        addSubviews(spinner)
        addSubviews(mapView)
        addSubviews(iconImageBGView)
        addSubviews(nameLabel)
        addSubviews(starImageView)
        addSubviews(originLabel)
        addSubviews(stateLabel)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        mapView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(viewMetrics.mapViewHeight)
        }
        [iconImageBGView, iconImageView].forEach { view in
            view.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalTo(mapView.snp.bottom)
                make.width.height.equalTo(viewMetrics.iconImageSide)
            }
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageBGView.snp.bottom).offset(viewMetrics.nameLabelTopOffset)
            make.left.equalToSuperview().inset(viewMetrics.labelsHorizontalInset)
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(viewMetrics.starImageInsets.left)
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(viewMetrics.starImageSide)
        }
        
        originLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalToSuperview().offset(viewMetrics.subtitleLabelsOffset.right)
            make.top.equalTo(nameLabel.snp.bottom).offset(viewMetrics.originLabelOffset.top)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.left.equalTo(originLabel.snp.left)
            make.right.equalToSuperview().offset(viewMetrics.subtitleLabelsOffset.right)
            make.top.equalTo(originLabel.snp.bottom).offset(viewMetrics.stateLabelOffset.top)
        }
    }

    // MARK: - Init

    func configure(with viewModel: DogBreedsDetailsViewModel) {
        mapView.setRegion(
            .init(
                center: CLLocationCoordinate2D(
                    latitude: viewModel.coordinates.latitude,
                    longitude: viewModel.coordinates.longitude
                ),
                latitudinalMeters: viewMetrics.mapScale,
                longitudinalMeters: viewMetrics.mapScale
            ),
            animated: true
        )
        iconImageView.image = viewModel.image
        nameLabel.text = viewModel.name
        originLabel.text = viewModel.origin
        stateLabel.text = viewModel.state
        starImageView.isHidden = !viewModel.isFavorite
    }

    // MARK: States

    func showLoading() {
        subviews.forEach { $0.isHidden = ($0 != spinner) }
    }

    func showView() {
        subviews.forEach { $0.isHidden = ($0 == spinner) }
    }
}
