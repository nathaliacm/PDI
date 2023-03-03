//
//  View.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 17/02/23.
//

import UIKit

public protocol ViewProtocol: AnyObject {
    var content: UIView { get }
    var delegate: ViewDelegate? { get set }
    func updateView(with data: Entity)
    func updateView(with error: String)
}

public protocol ViewDelegate: AnyObject {
    func didTapLoadCharactersButton(with path: String)
}

extension ViewProtocol where Self: UIView {
    public var content: UIView { return self }
}

final public class View: UIView, ViewProtocol {
    var data : Entity?
    
    public weak var delegate: ViewDelegate?
    
    private lazy var button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("load characters", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loadCharacters), for: .touchUpInside)
        return button
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func loadCharacters() {
        delegate?.didTapLoadCharactersButton(with: data?.characters ?? "")
    }
    
    public func updateView(with data: Entity) {
        self.data = data
        button.isEnabled = true
        button.setTitleColor(.systemPink, for: .normal)
    }
    
    public func updateView(with error: String) {

    }
}
