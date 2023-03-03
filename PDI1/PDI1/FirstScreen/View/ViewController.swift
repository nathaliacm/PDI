//
//  ViewController.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 27/02/23.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    var contentView: ViewProtocol? { get }
    var presenter: PresenterProtocol? { get set }
    
    func updateView(with data: Entity)
    func updateView(with error: String)
}

public class ViewController: UIViewController, ViewControllerProtocol {
    var presenter: PresenterProtocol?
    
    public let contentView: ViewProtocol?
    
    public init(contentView: ViewProtocol = View()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        contentSetup()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    func updateView(with data: Entity) {
        self.contentView?.updateView(with: data)
    }
    
    func updateView(with error: String) {
        
    }
}

extension ViewController: ViewDelegate {
    public func didTapLoadCharactersButton(with path: String) {
        presenter?.loadCharacters(with: path)
    }
}
