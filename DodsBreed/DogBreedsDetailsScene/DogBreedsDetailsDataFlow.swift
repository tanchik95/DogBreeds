//
//  DogBreedsDetailsDataFlow.swift
//
//  Created by Татьяна Аникина on 13.10.2022.
//

import Foundation

enum DogBreedsDetails {
    enum ShowItem {
        struct Request {
            let uid: UniqueIdentifier
        }

        struct Response {
            var result: Result<DogBreedsModel>

            enum Error: Swift.Error {
                case someError
            }
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum ViewControllerState {
        case initial(id: UniqueIdentifier)
        case loading
        case result(DogBreedsDetailsViewModel)
        case error(message: String)
    }
}
