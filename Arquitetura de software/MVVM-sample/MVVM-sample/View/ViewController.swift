//
//  ViewController.swift
//  MVVM-sample
//
//  Created by Nathalia Cardoso on 14/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var mvvmView: View?

    private var mvvmViewModel: ViewModel {
        didSet {
            updateView(entity: mvvmViewModel.personEntity)
        }
    }

    init(viewModel: ViewModel) {
        self.mvvmViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mvvmView = View(frame: UIScreen.main.bounds, controller: self)
        self.view = self.mvvmView
    }
    
    func handleEvent(firstName: String?) throws {
        guard let firstName = firstName else {
            throw EventError.EmptyEvent
        }
        mvvmViewModel.updateFirstName(to: firstName)
    }
    
    func updateView(entity: Entity) {
        self.mvvmView?.updateView(entity: entity)
    }

}

enum EventError : Error {
    case EmptyEvent
    case InvalidEvent
    case unknownEvent
}
