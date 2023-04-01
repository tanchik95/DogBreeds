//
//  Result.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
