//
//  DogBreedsDataFlow.swift
//
//  Created by Татьяна Аникина on 07.02.2023.
//

import UIKit

enum DogBreeds {
    enum DogBreedsList {
        struct Request {
            let isFavorite: Bool
        }

        struct Response {
            var result: Result<[DogBreedsModel]>

            enum Error: Swift.Error, LocalizedError {
                case fetchError
                case parsingError
                case notFound
                case someError

                var errorDescription: String? {
                    switch self {
                    case .fetchError:
                        return "Error loading data"
                    case .parsingError:
                        return "Data is invalid!"
                    case .notFound:
                        return "Nothing Found! Data is empty!"
                    case .someError:
                        return "Something went wrong..."
                    }
                }
            }
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum ViewControllerState {
        case loadingAll
        case loadingFavorites
        case result([DogBreedsViewModel])
        case error(message: String)
    }
}

