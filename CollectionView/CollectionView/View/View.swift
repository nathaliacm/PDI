//
//  View.swift
//  CollectionView
//
//  Created by Nathalia Cardoso on 17/02/23.
//

import UIKit

final public class View: UIView {
    
    var data : [ColorsModel] = colorMockData
    
    typealias DataSource = UICollectionViewDiffableDataSource<ColorType, ColorsModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ColorType, ColorsModel>
    
    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellIdentifier)
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
        applySnapshot(colors: data)
    }
}

// MARK: Diffable Datasource Configuration

extension View {
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView,
                                cellProvider: { (collectionView, indexPath, color) -> ColorCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) as? ColorCell
            cell?.updateView(with: color)
            return cell
            
        })
    }
    
    private func applySnapshot(colors: [ColorsModel]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([ColorType.primary, ColorType.secondary])
        snapshot.appendItems(data)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: Compositional Layout

extension View {
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

extension View: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let color = dataSource?.itemIdentifier(for: indexPath) else { return }
        snapshot.deleteItems([color])
        dataSource?.apply(snapshot)
    }
}
