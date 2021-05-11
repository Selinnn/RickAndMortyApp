//
//  CharactersVC.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import UIKit
import SnapKit

class CharactersVC: UIViewController {
    
    let viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = "Characters"
            navigationController?.navigationBar.layoutMargins.left = 30
            
            let attributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white,
                ]
            navigationController?.navigationBar.largeTitleTextAttributes = attributes
        }
        collectionView.showsVerticalScrollIndicator = false
        collectionView.reloadData()

    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero,collectionViewLayout: layout)
        view.addSubview(collection)
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(150)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.bottom.equalTo(-50)
        }
        collection.register(CharactersCell.self, forCellWithReuseIdentifier: CharactersCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .black
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
       
       }
   
}

extension CharactersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.identifier, for: indexPath) as! CharactersCell
        cell.cellModel = viewModel.modelFor(row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 15, height: collectionView.frame.width / 2 + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
}
