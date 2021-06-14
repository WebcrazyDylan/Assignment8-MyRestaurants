//
//  CollectionViewController.swift
//  MyRestaurants
//
//  Created by Dylan Park on 2021-06-01.
//

import UIKit


class CollectionViewController: UICollectionViewController {
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
  
  var filterItems: [Item] {
    return Type.allCases.map { .filter($0) }
  }
  var filteredItems = Restaurant.restaurants
  var restaurantItems: [Item] {
    return filteredItems.map { .restaurant($0) }
  }
  var layout: Layout = .column
  lazy var layoutButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(changeLayout(_:)))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "My Restaurants"
    navigationController?.navigationBar.prefersLargeTitles = true
    collectionView.backgroundColor = .white
    changeLayout(layoutButton)
    
    collectionView.register(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: FiltersCollectionViewCell.identifier)
    collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifier)
    collectionView.collectionViewLayout = generateLayout()
    createDataSource()
  }
  
  @objc func changeLayout(_ sender: UIBarButtonItem) {
    layout.toggle()
    sender.image = UIImage(named: layout.rawValue)
    navigationItem.rightBarButtonItem = sender
    navigationItem.rightBarButtonItem?.tintColor = .black
    
    collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    
//    collectionView.scrollToItem(at: [0,0], at: .top, animated: false)
    navigationController?.navigationBar.isTranslucent.toggle()
    collectionView.contentOffset = .zero
    navigationController?.navigationBar.isTranslucent.toggle()
  }
  
  private func createDataSource() {
    dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
      switch item {
      case .filter(let filter):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.identifier, for: indexPath) as! FiltersCollectionViewCell
        cell.button.setTitle(filter.rawValue.capitalized, for: .normal)
        cell.button.addTarget(cell, action: #selector(FiltersCollectionViewCell.buttonPressed(_:)), for: .touchUpInside)
        cell.button.isSelected = Type.selectedTypes[filter] ?? false
        cell.delegate = self
        return cell
      case .restaurant(let restaurant):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifier, for: indexPath) as! RestaurantCollectionViewCell
        cell.setup(with: restaurant)
        return cell
      }
    })
    applySnapshot()
  }
  
  private func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapshot.appendSections([.filters, .restaurants])
    snapshot.appendItems(filterItems, toSection: .filters)
    snapshot.appendItems(restaurantItems, toSection: .restaurants)
    dataSource.apply(snapshot)
  }
  
  fileprivate func layoutFilterSection() -> NSCollectionLayoutSection? {
    let item = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .estimated(100),
        heightDimension: .fractionalHeight(1)))
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: item.layoutSize.widthDimension,
        heightDimension: .estimated(25)),
      subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0)
    section.orthogonalScrollingBehavior = .continuous
    return section
  }
  
  fileprivate func layoutRestaurantSection() -> NSCollectionLayoutSection? {
    var group: NSCollectionLayoutGroup!
    
    switch layout {
    case .column:
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(1)))
      
      group = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalWidth(1)),
        subitem: item,
        count: 1)
    case .grid:
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1/2),
          heightDimension: .fractionalHeight(1)))
      
      group = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalWidth(1/2)),
        subitem: item,
        count: 2)
      group.interItemSpacing = .fixed(10)
    }

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
    return section
    
  }
  
  private func generateLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      return sectionIndex == 0 ? self.layoutFilterSection() : self.layoutRestaurantSection()
    }
    return layout
  }
}

extension CollectionViewController: FiltersCollectionViewCellDelegate {
  func filterSelected() {
    filteredItems = Restaurant.restaurants
    if !Type.selectedTypes.isEmpty {
      filteredItems = filteredItems.filter({ (restaurant) -> Bool in
        for type in restaurant.types where Type.selectedTypes[type] != nil { return true }
        return false
      })
    }
    applySnapshot()
  }
}
