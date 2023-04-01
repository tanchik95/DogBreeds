
//  UITableView+Extension.swift
//
//  Created by Татьяна Аникина on 31.03.2023.
//

import UIKit.UITableView

extension UITableView {
    static func defaultReuseId(for elementType: UIView.Type) -> String {
        return String(describing: elementType)
    }

    func dequeueReusableCellWithRegistration<T: UITableViewCell>(type: T.Type, indexPath: IndexPath, reuseId: String? = nil) -> T {
        let normalizedReuseId = reuseId ?? UITableView.defaultReuseId(for: T.self)
        if let cell = dequeueReusableCell(withIdentifier: normalizedReuseId) as? T {
            return cell
        }
        register(type, forCellReuseIdentifier: normalizedReuseId)

        guard let cell = dequeueReusableCell(withIdentifier: normalizedReuseId, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable cell for indexPath: \((indexPath.section, indexPath.item))")
        }
        return cell
    }

    func dequeueReusableHeaderFooterWithRegistration<T: UITableViewHeaderFooterView>(type: T.Type, reuseId: String? = nil) -> T {
        let normalizedReuseId = reuseId ?? UITableView.defaultReuseId(for: T.self)
        if let view = dequeueReusableHeaderFooterView(withIdentifier: normalizedReuseId) as? T {
            return view
        }
        register(type, forHeaderFooterViewReuseIdentifier: normalizedReuseId)

        guard let header = dequeueReusableHeaderFooterView(withIdentifier: normalizedReuseId) as? T else {
            fatalError("Unable to dequeue reusable header")
        }
        return header
    }
}

