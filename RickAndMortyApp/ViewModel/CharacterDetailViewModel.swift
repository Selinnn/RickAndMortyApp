//
//  CharacterDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 13.05.2021.
//

import UIKit

class CharacterDetailViewModel {
    
    var titles = [String]()

    func modelFor(row: Int) -> CharacterDetailCell.Model {
        let model = CharacterDetailCell.Model(title: "Episodes")
        return model
    }
}

