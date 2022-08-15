//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: -  IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    
    var model: DetailItemModel?
    let arrayWithTypeOfCells: [UITableViewCell] = [
                                DetailImageTableViewCell(),
                                DetailTitleTableViewCell(),
                                DetailContentTableViewCell()
    ]
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        leftSwipeForPop()
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
        arrayWithTypeOfCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model else { return UITableViewCell()}
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageTableViewCell.self)")
            if let cell = cell as? DetailImageTableViewCell {
                cell.configure(model: model)
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
           
            if let cell = cell as? DetailTitleTableViewCell {
                cell.configure(model: model)
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailContentTableViewCell.self)")
            if let cell = cell as? DetailContentTableViewCell {
                cell.configure(model: model)
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

    //MARK: - Methods

extension DetailViewController: UIGestureRecognizerDelegate {
    
    func leftSwipeForPop() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
}

