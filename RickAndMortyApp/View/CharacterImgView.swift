//
//  CharacterImgView.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import UIKit
import SnapKit
import Foundation

class CharacterImgView: UIView {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private lazy var imageViews = [imageView]
    
    var model: Model? {
        didSet {
            if let model = model {setupView(model:model)}
        }
    }
    
    private func setupView(model: Model) {
        for (index,view) in imageViews.enumerated() {
            let hasAnotherImage = model.characterImgs!.count > index
            if hasAnotherImage {
                view.image = model.characterImgs?[index]
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Model {
        var characterImgs: [UIImage]?
    }

    
}
