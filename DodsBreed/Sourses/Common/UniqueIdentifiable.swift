//
//  UniqueIdentifiable.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import Foundation

typealias UniqueIdentifier = Int

protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}

