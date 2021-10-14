//
//  FilmsResponseModel.swift
//  MiniKinopoisk
//
//  Created by Евгений Таракин on 26.09.2021.
//

import Foundation

struct FilmsListResponseModel: Decodable {
    let films: [AllFilmsListResponseModel]
}

struct AllFilmsListResponseModel: Decodable {
    let id: Int?
    let localized_name: String
    let name: String
    let year: Int
    let rating: Double?
    let image_url: URL?
    let description: String?
    let genres: [String?]
}
