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
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderImage: UIImageView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        setupPlaceholder()
    }

    //MARK: - TouchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
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
    
    //MARK: - Setup SerchBar
    
    func setupSearchBar() {
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchTextField.layer.cornerRadius = 16 //???? 22
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = Constants.Color.serchColor
        searchBar.placeholder = "Поиск"
        searchBar.delegate = self
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
