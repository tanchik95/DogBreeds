//
//  DogBreedsFavoriteCell.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//

import UIKit

protocol BreedDogTableViewCellDelegate : AnyObject {
    func didChangeSwitchState(_: BreedsDogsFavoriteCell, isOn: Bool)
}

final class BreedsDogsFavoriteCell: UITableViewCell {

    weak var delegate: BreedDogTableViewCellDelegate?
    var onChange: ((_ value: Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchAction(_ sender: UISwitch) {
            self.delegate?.didChangeSwitchState(self, isOn: switchFavorites.isOn)
    }

    lazy var switchFavorites: UISwitch = {
        let switchFavorites = UISwitch(frame: CGRect(x: 300 , y: 10, width: 20, height: 20))
        switchFavorites.addTarget(self, action: #selector(switchAction), for: .valueChanged)

        return switchFavorites
    }()

    private func swithcConstraint() {
        switchFavorites.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(switchFavorites)
        swithcConstraint()

        switchFavorites.addTarget(self, action: #selector(switchAction), for: UIControl.Event.valueChanged)

    }
}

extension BreedsDogsFavoriteCell: BreedDogTableViewCellDelegate {
    func didChangeSwitchState(_: BreedsDogsFavoriteCell, isOn: Bool) {
        self.onChange?(isOn)
    }
}

