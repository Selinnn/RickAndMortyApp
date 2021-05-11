//
//  CharactersCell.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import UIKit

class CharactersCell: UICollectionViewCell {
    
    static let identifier = "CharactersCollectionCell"
    
    private let collageİPadding: CGFloat = 30
    
    private lazy var collageView: CharacterImgView = {
        let frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height - collageİPadding)
        let collageView = CharacterImgView(frame: frame)
        contentView.addSubview(collageView)
        collageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return collageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(collageView.snp.bottom).offset(5)
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
        collageView.model = cellModel.model
        titleLabel.text = cellModel.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Model {
        var title: String?
        var model: CharacterImgView.Model?
    }
    override func prepareForReuse() {
        cellModel = nil
    }
}
