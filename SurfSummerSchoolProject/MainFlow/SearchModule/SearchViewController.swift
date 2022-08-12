//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderImage: UIImageView!
    
    //MARK: - Private Properties
    
    private var searchController = UISearchController()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        leftSwipeForPop()
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

//MARK: - UISearchResultsUpdating LogicSearch

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let resultSearchVC = searchController.searchResultsController as! MainViewController
        resultSearchVC.searchBarIsEmpty = searchText.isEmpty
        
        if resultSearchVC.searchBarIsEmpty {
            print("isEmpty")
            resultSearchVC.filteredItems = []
            resultSearchVC.collectionView.reloadData()
        } else {
            resultSearchVC.isFiltering = true
            resultSearchVC.filteredItems = resultSearchVC.model.items.filter({ (item: DetailItemModel) -> Bool in
                return item.title.lowercased().contains(searchText.lowercased())
            })
            
            resultSearchVC.collectionView.reloadData()
            
        }
        print(searchText)
    }
}

//MARK: - Extensions for Method

extension SearchViewController: UIGestureRecognizerDelegate {
    
    func leftSwipeForPop() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
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
    }
    
    //MARK: - Setup SerchBar
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: MainViewController())
        let searchBar = searchController.searchBar
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchTextField.layer.cornerRadius = 22
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = Constants.Color.serchColor
        searchBar.placeholder = "Поиск"
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.showsCancelButton = false
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

