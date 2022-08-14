//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: -  IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    var searchBarIsEmpty = true
    var filteredItems = [DetailItemModel]()
    var isFiltering = false
    
    //MARK: - Private Properties
    
    let model: MainModel = .init()
    private var isEmptyView = UIView()
    /// pull refresh
    private lazy var picturePullRefresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, #file)
        configureLoadingIndicator()
        configureNavigationBar()
        configureApireance()
        showErrorMessage()
        configureModel()
        model.loadPosts()
        collectionView.refreshControl = picturePullRefresh
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
}

    //MARK: - Private Methods
    
private extension MainViewController {
    
    func showErrorMessage() {
        model.didGetError = { [weak self] in
            self?.navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 12)
            ]
            self?.navigationController?.navigationBar.tintColor = .white
            self?.navigationItem.prompt = self?.model.errorMessage
            //self?.navigationController?.navigationBar.prefersLargeTitles = true
            self?.view.backgroundColor = Constants.Color.errorNavBar
            self?.title = "Попробуйте позже"
            self?.navigationItem.rightBarButtonItem = nil
            self?.navigationController?.navigationBar.backgroundColor = Constants.Color.errorNavBar
        }
    }
    
    func configureLoadingIndicator() {
        loadingIndicatorView.isHidden = true
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.style = .large
        loadingIndicatorView.startAnimating()
        
    }
    
    func configureNavigationBar() {
        tabBarController?.tabBar.isHidden = false
        navigationItem.rightBarButtonItem = createBarButton(image: Constants.Image.searchNavBar, tintColor: .black)
    }
    
    func configureApireance() {
        collectionView.register(MainCollectionViewCell.self)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.loadingIndicatorView.stopAnimating()
                self?.collectionView.reloadData()
                self?.checkForEmptyModel(isModelEmpty: self?.model.items.isEmpty ?? true)
            }
        }
    }
    
    func checkForEmptyModel(isModelEmpty: Bool) {
        if model.items.isEmpty {
            showEmptyView()
        }
    }
    
    func createEmptyView() -> UIView {
        let imageEmpty = UIImageView()
        imageEmpty.image = Constants.Image.emptyMain
        
        let emptyMessageLabel = UILabel(name: "Не удалось загрузить ленту \n Обновите экран или попробуйте позже")
        emptyMessageLabel.textColor = Constants.Color.dateText
        
        let restartButton = UIButton(title: "Обновить", backgroundCollor: .black, titleColor: .white)
        restartButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        restartButton.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
        
        let emptyView = MainEmptyState(imageEmpty: imageEmpty, label: emptyMessageLabel, button: restartButton)
        
        return emptyView
    }
    
    func showEmptyView() {
        isEmptyView = createEmptyView()
        self.view.addSubview(isEmptyView)
        
        NSLayoutConstraint.activate([
            isEmptyView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            isEmptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            isEmptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
    func createBarButton(image: UIImage, tintColor: UIColor) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(tapSearchButton(param:)))
        barButton.tintColor = tintColor
        return barButton
    }
    
    //MARK: - Action for buttons
    
    /// pull refresh func
    @objc private func pullRefresh(sender: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.reloadData()
            self.checkForEmptyModel(isModelEmpty: self.model.items.isEmpty)
            self.showErrorMessage()
        }
        sender.endRefreshing()
    }
    
    @objc func restartAction() {
        print(#function)
        isEmptyView.removeFromSuperview()
        configureLoadingIndicator()
        configureModel()
        model.loadPosts()
        
    }
    
    @objc func tapSearchButton(param: UIBarButtonItem) {
        /// implement presenter routing
        let vc = SearchViewController()
        vc.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
    
    //MARK: -  UIcollection delegate dataSource
    
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredItems.count
        } else {
            return model.items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            var item: DetailItemModel
            if isFiltering {
                item = filteredItems[indexPath.item]
            } else {
                item = model.items[indexPath.item]
            }
            cell.configure(model: item)
            cell.didFavoriteTapped = { [weak self] in
            self?.model.items[indexPath.item].isFavorite.toggle()
            }
        }
        return cell
    }
    
    ///FlowLayout delegate
    
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
        print(#function)
        let pictureItem: DetailItemModel
                    if isFiltering {
                        pictureItem = filteredItems[indexPath.item]
                    } else {
                        pictureItem = model.items[indexPath.item]
                    }

        let detailVC = DetailViewController()
        detailVC.model = pictureItem
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
