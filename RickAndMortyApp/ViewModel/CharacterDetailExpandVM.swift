//
//  CharacterDetailExpandVM.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 13.05.2021.
//

class CharacterDetailExpandVM {
    
    var titles = [String]()

    func modelFor(row: Int) -> CharacterDetailCell.Model {
            let model = CharacterDetailCell.Model(title: titles[row])
            return model
    }
}

