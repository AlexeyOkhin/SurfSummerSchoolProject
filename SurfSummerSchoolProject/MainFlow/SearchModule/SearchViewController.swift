//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureNavigationBar()
        setupSearchBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
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
        tabBarController?.tabBar.isHidden = true
        let backButton = UIBarButtonItem(image: Constants.Image.arrowLeft,
                                        style: .plain,
                                        target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = self
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
