//
//  UsersViewController.swift
//  DiscourseClient
//
// Created by Jorge Sanchez on 15/03/2021.
//

import UIKit

class UsersViewController: UIViewController {
    let viewModel: UsersViewModel
    
    let flowLayout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "UserCell")
        
        return collection
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
      
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flowLayout.minimumInteritemSpacing = 20.5
        flowLayout.itemSize = CGSize(width: 94, height: 124)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumLineSpacing = 18
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }

    fileprivate func showErrorFetchingUsers() {
        showAlert("Error fetching users\nPlease try again later")
    }
}

extension UsersViewController: UICollectionViewDataSource{
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as?  UserCell,
              let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
    
}


//MARK: -Al seleccionar un usuario
extension UsersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

//MARK: -UserViewController
extension UsersViewController: UsersViewModelViewDelegate {
    func usersWereFetched() {
        collectionView.reloadData()
        //tableView.reloadData()
    }

    func errorFetchingUsers() {
        showErrorFetchingUsers()
    }
}

//    lazy var tableView: UITableView = {
//        let table = UITableView(frame: .zero, style: .grouped)
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.dataSource = self
//        table.delegate = self
//        table.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
//        table.estimatedRowHeight = 100
//        table.rowHeight = UITableView.automaticDimension
//        return table
//    }()


//extension UsersViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.numberOfSections()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRows(in: section)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell,
//            let cellViewModel = viewModel.viewModel(at: indexPath) {
//            cell.viewModel = cellViewModel
//            return cell
//        }
//
//        fatalError()
//    }
//}

//extension UsersViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        viewModel.didSelectRow(at: indexPath)
//    }
//}
