//
//  File.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import Foundation
import UIKit

struct Characters: Decodable {
    var results: [CharactersResult]
}

struct CharactersResult: Decodable {
    var id: Int
    var name: String
    var image: String
}
