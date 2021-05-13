//
//  CharactersViewModel.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import UIKit

class CharactersViewModel {
    
    var imagesNames = [String]()
    var titles = [String]()

    func modelFor(row: Int) -> CharactersCell.Model {
        let collageModel = CharacterImgView.Model(characterImgs: imagesNames[row] as! String)
        let model = CharactersCell.Model(title: titles[row], model: collageModel)
        
        return model
    }
  

}
