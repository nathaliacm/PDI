//
//  ColorCell.swift
//  CollectionView
//
//  Created by Nathalia Cardoso on 17/02/23.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    //MARK: Properities
    
    static let cellIdentifier = "ColorCell"
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.frame = contentView.bounds
    }
    
    func configure(){
        contentView.addSubview(colorView)
    }
    
    func updateView(with model: ColorsModel) {
        colorView.backgroundColor = model.color
    }
    
}
