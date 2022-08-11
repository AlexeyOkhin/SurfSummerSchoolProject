//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - IBOutlets
    
    //@IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderImage: UIImageView!
    
    
    //MARK: - Private Properties
    
    private var searchController = UISearchController(searchResultsController: MainViewController())
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
       // navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        setupPlaceholder()
        
    }

    //MARK: - TouchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchController.searchBar.endEditing(true)
    }
}

//MARK: - SearchBar delegate

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
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
        //navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - Setup SerchBar
    
    func setupSearchBar() {
        
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.searchTextField.layer.cornerRadius = 16 //???? 22
        searchController.searchBar.searchTextField.layer.masksToBounds = true
        searchController.searchBar.searchTextField.backgroundColor = Constants.Color.serchColor
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    func setupPlaceholder() {
        placeholderImage.image = Constants.Image.magnifire
        
        placeholderLabel.text = "Введите ваш запрос"
        placeholderLabel.font = .systemFont(ofSize: 14)
        placeholderLabel.textColor = Constants.Color.placeholderSearch
        placeholderLabel.textAlignment = .center
    }
    
    
}
