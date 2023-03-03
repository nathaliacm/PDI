//
//  ViewController.swift
//  CollectionView
//
//  Created by Nathalia Cardoso on 17/02/23.
//

import UIKit

class ViewController: UIViewController {
    public let contentView: View?

    public init(contentView: View = View()) {
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
            self.view = contentView
            contentView.frame = view.bounds
        }
    }
}
