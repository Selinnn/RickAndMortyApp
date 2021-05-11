//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import UIKit

class CharactersViewModel {
    
    private let imagesNames = ["rick","together","mom","idk"]
    private let titles = ["Rick","And","Morty","Serie"]

    func numberOfRows() -> Int {
        return 20
    }
    
    func modelFor(row: Int) -> CharactersCell.Model {
        let randomImages = imagesNames.random(3)
        let title = titles.randomElement()
        let collageModel = CharacterImgView.Model(characterImgs: randomImages)
        let model = CharactersCell.Model(title: title, model: collageModel)
        
        return model
    }

}

extension Collection {
    private func choose(_ n: Int) -> ArraySlice<Element> {
        shuffled().prefix(n)
    }
    
    func random(_ n: Int) -> [UIImage] {
        let names = choose(n)
        let images = names.map { return UIImage(named: $0 as! String)! }
        return images
    }
}
