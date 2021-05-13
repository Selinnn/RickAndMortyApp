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
    let viewModel2: CharacterDetailViewModel
    let viewModel3: CharacterDetailExpandVM
    var characters: Characters?
    var chModels = [CharacterModel]()
    
    init(viewModel: CharactersViewModel, viewModel2: CharacterDetailViewModel, viewModel3: CharacterDetailExpandVM) {
        self.viewModel = viewModel
        self.viewModel2 = viewModel2
        self.viewModel3 = viewModel3
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
            navigationController?.navigationBar.barTintColor = .black
            
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
    
       func createModel() {
        for i in 1..<characters!.results.count {
            let ch = characters!.results[i]
            viewModel.imagesNames.append(ch.image)
            viewModel.titles.append(ch.name)
           }
           self.collectionView.reloadData()
       }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           
           let postRequest = APIRequest(fullurl: "https://rickandmortyapi.com/api/character")
        postRequest.post(completion: { [self] result in
               switch result {
               case .success(let ch):
                   print("success")
                self.characters = ch
                DispatchQueue.main.async {
                    self.createModel()
                               }
               case .failure(let error):
                   print("failure \(error)")
               }
           })
       }
   
}

extension CharactersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCell.identifier, for: indexPath) as! CharactersCell
        cell.cellModel = viewModel.modelFor(row: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userConVC = UINavigationController(rootViewController: CharacterDetailVC(characterID: characters?.results[indexPath.row].id ?? 0, viewModel: viewModel2, viewModel2: viewModel3))
        userConVC.view.backgroundColor = UIColor(red: 19.0 / 255.0, green: 20.0 / 255.0, blue: 21.0 / 255.0, alpha: 1.0)
        self.present(userConVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 15, height: collectionView.frame.width / 2 + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
    
}
