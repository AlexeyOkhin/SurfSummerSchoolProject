//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

final class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Private Properties
    
    private var emptyView = UIView()
    private var favoritesPictures = [DetailItemModel]()
    private var model = MainModel.shared
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureApireance()
        //configureModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        configureModel()
        showEmptyView()
    }
}

    //MARK: - Private Methods
    
private extension FavoriteViewController {
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = createBarButton(image: Constants.Image.searchNavBar, tintColor: Constants.Color.appBlack)
    }
    
    func configureApireance() {
        collectionView.register(FavoriteCollectionViewCell.self)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
    func configureModel() {
        favoritesPictures = model.items.filter({ item in
            item.isFavorite == true
        })
        collectionView.reloadData()
    }
    
    func createBarButton(image: UIImage, tintColor: UIColor) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(tapSearchButton(param:)))
        barButton.tintColor = tintColor
        return barButton
    }
    
    @objc func tapSearchButton(param: UIBarButtonItem) {
        let searchViewController = SearchViewController()
        searchViewController.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func createEmptyView(with image: UIImage, and message: String) -> UIView {
        let imageEmpty = UIImageView()
        imageEmpty.image = image
        
        let emptyMessageLabel = UILabel(name: message)
        emptyMessageLabel.textColor = Constants.Color.dateText
        
        let emptyView = EmptyState(imageEmpty: imageEmpty, label: emptyMessageLabel)
        
        return emptyView
    }
    
    func configureEmptyView(with image: UIImage, and message: String) {
        emptyView = createEmptyView(with: image, and: message)
        self.view.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emptyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            emptyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
    func showEmptyView() {
        if favoritesPictures.isEmpty {
            configureEmptyView(with: Constants.Image.emptyMain, and: "В избранном пусто")
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    func alertForTapFavorites(forIndex: IndexPath, item: DetailItemModel) {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)
        let buttonActionCancel = UIAlertAction(title: "Нет", style: .cancel)
        let buttonActionAccept = UIAlertAction(title: "Да, точно", style: .default) { _ in
            if let indexMain = (self.model.items.enumerated().first{ $1.id == item.id })?.offset {
                self.model.items[indexMain].isFavorite.toggle()
            }
            do {
                try FavoriteStorage().saveFavoriteStatus(by: self.favoritesPictures[forIndex.row].id, new: false)
                self.favoritesPictures.remove(at: forIndex.row)
                self.collectionView.reloadData()
                self.showEmptyView()
            } catch let error {
                print(error)
            }
        }
        
        alert.addAction(buttonActionCancel)
        alert.addAction(buttonActionAccept)
        alert.preferredAction = buttonActionAccept
        self.present(alert, animated: true)
    }
}

    
    //MARK: -  UICollectionViewController DataSource
    
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritesPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteCollectionViewCell {
            let item = favoritesPictures[indexPath.item]
            cell.configure(model: item)
            cell.tapForFavorites = {
                self.alertForTapFavorites(forIndex: indexPath, item: item)
            }
        }
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.Size.horisontalInset * 2)
        let itemHeight = itemWidth * Constants.Size.aspectRatioFavarite
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.Size.favoriteSpacBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = DetailViewController()
        detailViewController.model = favoritesPictures[indexPath.item]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
