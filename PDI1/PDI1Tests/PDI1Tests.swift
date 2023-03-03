//
//  PDI1Tests.swift
//  PDI1Tests
//
//  Created by Nathalia Cardoso on 03/03/23.
//

import XCTest

@testable import PDI1

final class PDI1Tests: XCTestCase {

    var view: View!
    var charView: CharactersView!
    
    override func setUp() {
        super.setUp()
        
        let router = Router.assemble()
        let viewController = router.entry
        
        view = viewController?.contentView?.content as? View
        
        let charRouter = CharactersRouter.assemble(with: mockURL)
        let charViewController = charRouter.entry
        
        charView = charViewController?.contentView?.content as? CharactersView
    
    }

    func test_view_updateView_update() throws {
        // given
        let mockData = Entity.entityMockData
        
        // when
        view.updateView(with: mockData)
        
        // then
        XCTAssertEqual(mockData.characters, view.data?.characters)
    }
    
    func test_charactersView_updateView_update() throws {
        // given
        let mockData = ResultsEntity.resultsMockData
        
        // when
        charView.updateView(with: mockData)
        
        // then
        XCTAssertEqual(mockData.count, charView.data.count)
    }

}
