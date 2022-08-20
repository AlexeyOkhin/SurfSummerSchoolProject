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
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private Properties
    
    private var searchController = UISearchController()
    private var searchBarIsEmpty = true
    private var filteredItems = [DetailItemModel]()
    
    //MARK: - Properties
    
    var model: MainModel?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApireance()
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
        guard let searchText = searchController.searchBar.text, let model = model else { return }
        searchBarIsEmpty = searchText.isEmpty
        
        if searchBarIsEmpty {
            filteredItems = []
            collectionView.reloadData()
        } else {
            filteredItems = model.items.filter({ (item: DetailItemModel) -> Bool in
                return item.title.lowercased().contains(searchText.lowercased())
            })
            
            collectionView.reloadData()
        }
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
    
    func configureApireance() {
        collectionView.register(MainCollectionViewCell.self)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        let searchBar = searchController.searchBar
        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchTextField.layer.cornerRadius = 22
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = Constants.Color.serchColor
        searchBar.placeholder = "Поиск"
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.showsCancelButton = false
    }
    
    func setupPlaceholder() {
        placeholderImage.image = Constants.Image.magnifire
        
        placeholderLabel.text = "Введите ваш запрос"
        placeholderLabel.font = .systemFont(ofSize: 14)
        placeholderLabel.textColor = Constants.Color.placeholderSearch
        placeholderLabel.textAlignment = .center
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            var item: DetailItemModel
            item = filteredItems[indexPath.item]
            cell.configure(model: item)
            cell.didFavoriteTapped = { [weak self] in
                self?.model?.items[indexPath.item].isFavorite.toggle()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.Size.horisontalInset * 2 - Constants.Size.spaceBetweenElements) / 2
        let itemHeight = itemWidth * Constants.Size.aspectRatioMain
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Size.spacBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Size.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pictureItem: DetailItemModel
        pictureItem = filteredItems[indexPath.item]
        
        let detailVC = DetailViewController()
        detailVC.model = pictureItem
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

