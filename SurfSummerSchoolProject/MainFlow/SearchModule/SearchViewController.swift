//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 06.08.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private Properties
    
    private var searchController = UISearchController()
    private var searchBarIsEmpty = true
    private var filteredItems = [DetailItemModel]()
    private var emptyView = UIView()
    private var model = MainModel.shared
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApireance()
        setupSearchBar()
        leftSwipeForPop()
        showEmptyView(with: Constants.Image.magnifire, and: "Введите ваш запрос")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
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
        searchBarIsEmpty = searchText.isEmpty
        
        if searchBarIsEmpty {
            //showEmptyView()
            filteredItems = []
            collectionView.reloadData()
        } else {
            emptyView.removeFromSuperview()
            filteredItems = model.items.filter({ (item: DetailItemModel) -> Bool in
                return item.title.lowercased().contains(searchText.lowercased())
            })
            if filteredItems.isEmpty {
                showEmptyView(with: Constants.Image.emptyMain, and: "По этому запросу нет результатов \n попробуйте другой запрос")
            }
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
        backButton.tintColor = Constants.Color.appBlack
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
    
    func createEmptyView(with image: UIImage, and message: String) -> UIView {
        let imageEmpty = UIImageView()
        imageEmpty.image = image
        
        let emptyMessageLabel = UILabel(name: message)
        emptyMessageLabel.textColor = Constants.Color.dateText
        
        let emptyView = EmptyState(imageEmpty: imageEmpty, label: emptyMessageLabel)
        
        return emptyView
    }
    
    func showEmptyView(with image: UIImage, and message: String) {
        emptyView = createEmptyView(with: image, and: message)
        self.view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
            if let cell = cell as? MainCollectionViewCell {
                let item = filteredItems[indexPath.item]
                cell.configure(model: item)
                cell.didFavoriteTapped = { [weak self] in
                    self?.filteredItems[indexPath.item].isFavorite.toggle()
                    self?.collectionView.reloadItems(at: [indexPath])

                    if let indexMain = (self?.model.items.enumerated().first{ $1.id == item.id })?.offset {
                
                        self?.model.items[indexMain].isFavorite.toggle()
    
                        if let item = self?.model.items[indexMain] {
                            try? FavoriteStorage().saveFavoriteStatus(by: item.id, new: item.isFavorite)
                        }
                    }
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
        self.view.endEditing(true)
        let pictureItem: DetailItemModel
        pictureItem = filteredItems[indexPath.item]
        
        let detailViewController = DetailViewController()
        detailViewController.model = pictureItem
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

