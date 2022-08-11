//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: -  Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Private properties
    
    private let model: MainModel = .init()
    private var isEmptyView = UIView()
   
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLoadingIndicator()
        configureApireance()
        configureModel()
        model.loadPosts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

    //MARK: - Private Methods
    
private extension MainViewController {
    
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
    
    @objc func restartAction() {
        print(#function)
        isEmptyView.removeFromSuperview()
        configureLoadingIndicator()
        configureModel()
        model.loadPosts()
        
    }
    
    @objc func tapSearchButton(param: UIBarButtonItem) {
        /// implement presenter routing
        print(#function)
        print("tapSearch")
        let vc = SearchViewController()
        vc.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
    
    
    //MARK: -  UIcollection delegate dataSource
    
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainCollectionViewCell {
            let item = model.items[indexPath.item]
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
            cell.didFavoriteTapped = { [weak self] in
            self?.model.items[indexPath.item].isFavorite.toggle()
                
            }
        }
        return cell
    }
    
    ///FlowLayout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.Size.horisontalInset * 2 - Constants.Size.spaceBetweenElements) / 2
        let itemHeight = itemWidth * 1.46
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Size.spacBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Size.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        detailVC.model = model.items[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}