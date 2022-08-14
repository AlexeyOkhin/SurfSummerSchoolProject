//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private properties
    
    private let model: MainModel = .init()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
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
    
private extension FavoriteViewController {
    
    func configureNavigationBar() {
        title = "Избранное"
        navigationItem.rightBarButtonItem = createBarButton(image: Constants.Image.searchNavBar, tintColor: .black)
    }
    
    func configureApireance() {
        collectionView.register(FavoriteCollectionViewCell.self)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    func createBarButton(image: UIImage, tintColor: UIColor) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(tapSearchButton(param:)))
        barButton.tintColor = tintColor
        return barButton
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
    
    
    //MARK: -  UICollectionViewController DataSource
    
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    ///DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteCollectionViewCell {
            let item = model.items[indexPath.item]
            cell.imageUrlInString = item.imageUrlInString
            cell.title = item.title
            cell.date = item.dateCreation
            cell.content = item.content
        }
        return cell
    }
    
    ///FlowLayout delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.Size.horisontalInset * 2)
        let itemHeight = itemWidth * Constants.Size.aspectRatioFavarite
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Size.favoriteSpacBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        detailVC.model = model.items[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
