//
//  CharactersViewController.swift
//  PDI1
//
//  Created by Nathalia Cardoso on 02/03/23.
//

import UIKit

protocol CharactersViewControllerProtocol: AnyObject {
    var contentView: CharactersViewProtocol? { get }
    var presenter: CharactersPresenterProtocol? { get set }
    
    func updateView(with data: [CharactersEntity])
    func updateView(with error: String)
}

public class CharactersViewController: UIViewController, CharactersViewControllerProtocol {
    var presenter: CharactersPresenterProtocol?
    
    public let contentView: CharactersViewProtocol?
    
    public init(contentView: CharactersViewProtocol = CharactersView()) {
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
    }
    
    func updateView(with data: [CharactersEntity]) {
        DispatchQueue.main.async {
            self.contentView?.updateView(with: data)
        }
    }
    
    func updateView(with error: String) {
        
    }
}

