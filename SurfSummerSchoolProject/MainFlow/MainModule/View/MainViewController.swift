//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: -  Private IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    let model = MainModel.shared
    
    //MARK: - Private Properties
    
    private var isEmptyView = UIView()

    private lazy var picturePullRefresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.refreshControl = picturePullRefresh
        configureLoadingIndicator()
        configureNavigationBar()
        configureApireance()
        showErrorMessage()
        configureModel()
        model.loadPosts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        collectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
    }
}

    //MARK: - Private Methods
    
private extension MainViewController {
    
    func showErrorMessage() {
        model.didGetError = { [weak self] in
            self?.navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: Constants.Color.appWhite,
                .font: UIFont.systemFont(ofSize: 12)
            ]
            self?.navigationController?.navigationBar.tintColor = Constants.Color.appWhite
            self?.navigationItem.prompt = self?.model.errorMessage
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
        navigationItem.rightBarButtonItem = createBarButton(image: Constants.Image.searchNavBar, tintColor: Constants.Color.appBlack)
    }
    
    func configureApireance() {
        collectionView.register(MainCollectionViewCell.self)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self?.loadingIndicatorView.stopAnimating()
                self?.collectionView.reloadData()
                self?.checkForEmptyModel(isModelEmpty: self?.model.items.isEmpty ?? true)
                print(try! FavoriteStorage().getAllOfFavorites())
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
        
        let restartButton = UIButton(title: "Обновить", backgroundCollor: Constants.Color.appBlack, titleColor: Constants.Color.appWhite)
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
        let searchViewController = SearchViewController()
        searchViewController.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
}
    
    //MARK: -  UIcollection delegate dataSource
    
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            var item: DetailItemModel
            item = model.items[indexPath.item]
            cell.configure(model: item)
            cell.didFavoriteTapped = { [weak self] in
                do {
                    self?.model.items[indexPath.item].isFavorite.toggle()
                    try FavoriteStorage().saveFavoriteStatus(by: item.id, new: self?.model.items[indexPath.item].isFavorite ?? false)
                    collectionView.reloadItems(at: [indexPath])
                    print(try! FavoriteStorage().getAllOfFavorites())
                } catch let error{
                    print(error)
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
        print(#function)
        let pictureItem: DetailItemModel
        pictureItem = model.items[indexPath.item]
        
        let detailViewController = DetailViewController()
        detailViewController.model = pictureItem
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
