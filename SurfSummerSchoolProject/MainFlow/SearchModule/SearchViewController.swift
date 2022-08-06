//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupSearchBar()
    }
}

//MARK: - SearchBar delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: - Private Methods

private extension SearchViewController {
    
    //MARK: - Configure navigationBar
    
    func configureNavigationBar() {
        self.tabBarController?.tabBar.isHidden = true
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(popVC))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
    }
    // Action for leftBarButton
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - setup serchController
    func setupSearchBar() {
//        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchTextField.layer.cornerRadius = 22 //????
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = Constants.Color.serchColor
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
//        searchBar.hidesNavigationBarDuringPresentation = true
//        searchBar.obscuresBackgroundDuringPresentation = false
//        searchBar.searchBar.placeholder = "Поиск"
//        searchBar.searchBar.delegate = self
        definesPresentationContext = true
    }
}
