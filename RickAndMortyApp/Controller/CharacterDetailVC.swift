//
//  CharacterDetailVC.swift
//  RickAndMortyApp
//
//  Created by Selin KAPLAN on 11.05.2021.
//

import UIKit
import SnapKit
import ExpyTableView

class CharacterDetailVC: UIViewController {
    
    var characterID = 0
    let viewModel: CharacterDetailViewModel
    let viewModel2: CharacterDetailExpandVM
    var series = ""
    
    var characterDetail: CharacterDetail?
    var characterDetailModels = [CharacterDetailModels]()
    
    init(characterID: Int, viewModel: CharacterDetailViewModel, viewModel2: CharacterDetailExpandVM) {
        self.characterID = characterID
        self.viewModel = viewModel
        self.viewModel2 = viewModel2
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var chName: UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(30)
        }
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    lazy var chImage: UIImageView = {
        let image = UIImageView()
        view.addSubview(image)
        image.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.top.equalTo(chName.snp.bottom).offset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(120)
        }
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 60
       
        return image
    }()
    
    lazy var chType: UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalTo(chImage.snp.right).inset(-30)
            $0.top.equalToSuperview().inset(110)
        }
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var chGender: UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalTo(chImage.snp.right).inset(-30)
            $0.top.equalToSuperview().inset(150)
        }
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = ExpyTableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(chImage.snp.bottom).offset(30)
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
            $0.bottom.equalTo(-30)
        }
        tableView.separatorStyle = .none
        tableView.register(CharacterDetailCell.self, forCellReuseIdentifier: CharacterDetailCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 19.0 / 255.0, green: 20.0 / 255.0, blue: 21.0 / 255.0, alpha: 1.0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 19.0 / 255.0, green: 20.0 / 255.0, blue: 21.0 / 255.0, alpha: 1.0)
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done"), style: .plain, target: self, action:#selector(doneClick))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 138.0 / 255.0, green: 103.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
        tableView.reloadData()
    }
    
    func createModel() {
        for i in 0..<characterDetail!.episode.count {
            parseJson(url: URLRequest(url: URL(string: characterDetail!.episode[i])!))
           }
        self.tableView.reloadData()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
       func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
           getData(from: url) { data, response, error in
               guard let data = data, error == nil else { return }
               DispatchQueue.main.async() {
                   completion(UIImage(data: data))
               }
           }
           
       }
    
    func parseJson(url: URLRequest) {
        
        let task = URLSession.shared.dataTask(
                    with: url,
                    completionHandler: { data, response, error in
                        DispatchQueue.main.async(execute: {
                            guard let data = data else { return }
                            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return }
                            guard let jsonObj = json as? [String: Any] else { return }

                            guard let s = jsonObj["name"] as? String else { return }

                            print(s)
                            self.series = s
                            self.viewModel2.titles.append(self.series)
                        })
                
                    })
                task.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
        let postRequest = APIRequest(fullurl: "https://rickandmortyapi.com/api/character/\(characterID)")
        postRequest.get(completion: { [self] result in
               switch result {
               case .success(let ch):
                   print("success")
                self.characterDetail = ch
                DispatchQueue.main.async {
                    self.createModel()
                    chName.text = characterDetail?.name
                    downloadImage(from: URL(string: characterDetail?.image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, completion: { (img) in
                        chImage.image = img
                    })
                    chType.text = "\(characterDetail!.status), \(characterDetail!.species)"
                    chGender.text = characterDetail?.gender
                    
                               }
               case .failure(let error):
                   print("failure \(error)")
               }
           })
       }
    
    @objc func doneClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CharacterDetailVC: ExpyTableViewDataSource,ExpyTableViewDelegate {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  CharacterDetailCell.identifier) as!  CharacterDetailCell
        cell.cellModel =  viewModel.modelFor(row: section)
        cell.backgroundColor = UIColor(red: 28.0 / 255.0, green: 30.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        
        switch state {
        case .willExpand:
         print("WILL EXPAND")

        case .willCollapse:
         print("WILL COLLAPSE")

        case .didExpand:
         print("DID EXPAND")

        case .didCollapse:
         print("DID COLLAPSE")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterDetail?.episode.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  CharacterDetailCell.identifier, for: indexPath) as!  CharacterDetailCell
        cell.cellModel =  viewModel2.modelFor(row: indexPath.row)
        cell.backgroundColor = UIColor(red: 28.0 / 255.0, green: 30.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
