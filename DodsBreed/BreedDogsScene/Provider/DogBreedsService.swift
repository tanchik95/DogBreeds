//
//  DogBreedsService.swift
//
//  Created by Татьяна Аникина on 05.09.2022.
//


import Foundation

protocol DogBreedsServiceProtocol {
    func fetchItems(completion: @escaping ([DogBreedsModel]?, Error?) -> Void)
}

final class DogBreedsService {
    let decoder: JSONDecoder

    // MARK: - Init

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    // MARK: Private method

    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }

    private func parseSuccessData(data: Data) -> [DogBreedsModel]? {
        do {
            let models = try decoder.decode(DogBreedsResponse.self, from: data)
            return models
        } catch {
            return nil
        }
    }
}

// MARK: DogBreedsServiceProtocol

extension DogBreedsService: DogBreedsServiceProtocol {
    func fetchItems(completion: @escaping ([DogBreedsModel]?, Error?) -> Void) {
        guard let data = readLocalJSONFile(forName: "DogBreedsData") else {
            completion(nil, DogBreeds.DogBreedsList.Response.Error.fetchError)
            return
        }
        guard let models = parseSuccessData(data: data) else {
            completion(nil, DogBreeds.DogBreedsList.Response.Error.fetchError)
            return
        }
        if models.isEmpty {
            completion(nil, DogBreeds.DogBreedsList.Response.Error.notFound)
        } else {
            completion(models, nil)
        }
    }
}

