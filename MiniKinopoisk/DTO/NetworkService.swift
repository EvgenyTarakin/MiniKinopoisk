//
//  NetworkService.swift
//  MiniKinopoisk
//
//  Created by Евгений Таракин on 26.09.2021.
//

import Foundation
import Alamofire

struct NetworkConstants {
    struct URLString {
        static let filmsList = "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json"
    }
}

protocol FilmsListNetworkService {
    func getFilmsList(onRequestCompleted: @escaping ((FilmsListResponseModel?, Error?) -> ()))
}


class NetworkService: FilmsListNetworkService {
    
    func getFilmsList(onRequestCompleted: @escaping ((FilmsListResponseModel?, Error?) -> ())) {
        performGetRequest(urlString: NetworkConstants.URLString.filmsList, onRequestCompleted: onRequestCompleted)
    }
    
    private func performGetRequest<ResponseModel: Decodable>(urlString: String, method: HTTPMethod = .get, onRequestCompleted: @escaping ((ResponseModel?, Error?)->())) {
        AF.request(urlString,
                   method: method,
                   encoding: JSONEncoding.default
        ).response { (responseData) in
            guard responseData.error == nil,
                  let data = responseData.data
            else {
                onRequestCompleted(nil, responseData.error)
                return
            }
            do {
                let decodedValue: ResponseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                onRequestCompleted(decodedValue, nil)
            }
            catch (let error) {
                print("Response parsing error: \(error.localizedDescription)")
                onRequestCompleted(nil, error)
            }
        }
    }
    
}
