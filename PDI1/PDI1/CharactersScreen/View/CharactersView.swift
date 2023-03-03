//
//  CharactersView.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 02/03/23.
//

import UIKit

public protocol CharactersViewProtocol: AnyObject {
    var content: UIView { get }
    func updateView(with data: [CharactersEntity])
    func updateView(with error: String)
}

extension CharactersViewProtocol where Self: UIView {
    public var content: UIView { return self }
}

final public class CharactersView: UIView {
    var data : [CharactersEntity] = []
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CharactersEntity>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, CharactersEntity>
    
    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.cellIdentifier)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        return collectionView
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        collectionView.frame = bounds
    }

    private func setup() {
        addSubview(collectionView)
        
        configureCollectionViewDataSource()
    }
}

// MARK: Diffable Datasource Configuration

extension CharactersView {
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { (collectionView, indexPath, entity) -> ImageViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.cellIdentifier, for: indexPath) as? ImageViewCell
            cell?.updateView(with: entity.image ?? "")
            return cell
            
        })
    }
    
    private func applySnapshot(entity: [CharactersEntity]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: Compositional Layout

extension CharactersView {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // Item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1)
            )
        )

        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)

        let horizontalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2)
            )
        )

        horizontalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                                    leading: 2,
                                                                    bottom: 2,
                                                                    trailing: 2)
        
        // Groups
        let stackGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/2)),
            repeatingSubitem: item,
            count: 2
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(2/5)
            ),
            subitems: [
                stackGroup,
                horizontalStackItem
            ]
        )
        
        // Sections
        let section = NSCollectionLayoutSection(group: group)
        
        // Return
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension CharactersView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let color = dataSource?.itemIdentifier(for: indexPath) else { return }
        snapshot.deleteItems([color])
        dataSource?.apply(snapshot)
    }
}

extension CharactersView: CharactersViewProtocol {
    public func updateView(with data: [CharactersEntity]) {
        self.data = data
        self.applySnapshot(entity: data)
        backgroundColor = .lightGray
    }
    
    public func updateView(with error: String) {

    }
}

