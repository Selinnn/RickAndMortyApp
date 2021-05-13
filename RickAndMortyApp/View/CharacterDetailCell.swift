//
//  CharacterDetailCell.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 13.05.2021.
//

import Foundation
import UIKit

class CharacterDetailCell: UITableViewCell {
    static let identifier = "CharacterDetailCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(14)
        }
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    var cellModel: Model? {
        didSet {
            setupUI(cellModel: cellModel)
        }
    }
    
    private func setupUI(cellModel: Model?) {
        guard let cellModel = cellModel else {return}
        titleLabel.text = cellModel.title
    }
    
    struct Model {
        var title: String?
    }
    override func prepareForReuse() {
        cellModel = nil
    }
    
}
