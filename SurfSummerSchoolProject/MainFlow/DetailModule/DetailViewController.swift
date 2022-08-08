//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: -  IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    
    var model: DetailItemModel?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

//MARK: - Private Method

private extension DetailViewController {
    
    
    func configureAppearance() {
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = model?.title
        let backButton = UIBarButtonItem(image: Constants.Image.arrowLeft,
                                        style: .plain,
                                        target: navigationController,
                                        action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureTableView() {
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(DetailImageTableViewCell.self)
        tableView.register(DetailTitleTableViewCell.self)
        tableView.register(DetailContentTableViewCell.self)
    }
}

//MARK: - DataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageTableViewCell.self)")
            if let cell = cell as? DetailImageTableViewCell {
                cell.image = model?.image
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
           
            if let cell = cell as? DetailTitleTableViewCell {
                cell.title = model?.title
                cell.date = model?.dateCreate
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailContentTableViewCell.self)")
            if let cell = cell as? DetailContentTableViewCell {
                cell.content = model?.content
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

