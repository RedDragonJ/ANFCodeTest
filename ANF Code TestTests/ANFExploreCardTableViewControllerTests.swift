//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ANFExploreCardTableViewController.self))
        testInstance = storyboard.instantiateViewController(withIdentifier: "ANFExploreCardTableViewController") as? ANFExploreCardTableViewController
        testInstance.dataProvider = MockExploreDataProvider()
        _ = testInstance.view
    }

    func fetchConfiguredCell(at indexPath: IndexPath) -> ANFExploreTableViewCell? {
        return testInstance.tableView(testInstance.tableView, cellForRowAt: indexPath) as? ANFExploreTableViewCell
    }

    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldBeTen() {
        let numberOfRows = testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0)
        XCTAssert(numberOfRows == 2, "table view should have 10 cells")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldMatchMockData() {
        let cell = fetchConfiguredCell(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.titleLabel.text, "Test Title 1", "The title should match the mock data")
    }

    func test_cellForRowAtIndexPath_promoMessage_shouldMatchMockData() {
        let cell = fetchConfiguredCell(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.promoMessageLabel.text, "Promo 1", "The promo message should match the mock data")
    }
}
