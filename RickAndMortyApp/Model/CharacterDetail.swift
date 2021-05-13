//
//  CharacterDetail.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 13.05.2021.
//

import Foundation

struct CharacterDetail: Decodable {
    var episode = [String]()
    var name: String
    var status: String
    var species: String
    var gender: String
    var image: String
}
