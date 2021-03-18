//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {
    
    //MARK: REFRESCAR LA LISTA
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        return refreshControl
    }()
    
    
    //MARK: - FAB
    lazy var fabButton: UIButton = {
        let fab = UIButton()
        fab.translatesAutoresizingMaskIntoConstraints = false
        //fab.frame = CGRect(x: 250, y: 485, width: 100, height: 100)
        let fabIcon = UIImage(named: "icoNew")
        fab.layer.cornerRadius = 32
        fab.setImage(fabIcon, for: .normal)
        fab.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return fab
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")        
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: loadView
    override func loadView() {
        view = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.refreshControl = refreshControl
        //fabButton.pinToSuperView()
        view.addSubview(fabButton)
        NSLayoutConstraint.activate(
            [fabButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
             fabButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)])    
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.viewWasLoaded()
        
    }
    

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }
    @objc func refreshControlPulled() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }

    fileprivate func showErrorFetchingTopicsAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topics\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cellViewModel.cellViewModelDelegate = self
            cell.viewModel = cellViewModel
            return cell
        }

        fatalError()
    }
}

extension TopicsViewController: TopicCellViewModelDelegate{
    func imageDidFetched() {
        tableView.reloadData()
    }
    
}
extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
    }

    func errorFetchingTopics() {
        showErrorFetchingTopicsAlert()
    }
}

extension UIView{
    func pinToSuperView(){
        guard let superview =  self.superview else {return}
        
        NSLayoutConstraint.activate(
            [rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor),
             bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            
            ])
    }
}
