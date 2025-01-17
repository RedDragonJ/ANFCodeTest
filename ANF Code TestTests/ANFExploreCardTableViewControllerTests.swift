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
        let expectation = XCTestExpectation(description: "Data is loaded and table view is updated")

        // Wait for viewDidLoad to trigger fetchData and update the table view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }

            let numberOfRows = self.testInstance.tableView(self.testInstance.tableView, numberOfRowsInSection: 0)
            XCTAssert(numberOfRows == 2, "Table view should have 2 cells")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldMatchMockData() {
        let expectation = XCTestExpectation(description: "Data is loaded and table view is updated")

        // Wait for data fetching to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            let cell = self.fetchConfiguredCell(at: IndexPath(row: 0, section: 0))
            XCTAssertEqual(cell?.titleLabel.text, "Test Title 1", "The title should match the mock data")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_cellForRowAtIndexPath_promoMessage_shouldMatchMockData() {
        let expectation = XCTestExpectation(description: "Data is loaded and table view is updated")

        // Wait for data fetching to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            let cell = self.fetchConfiguredCell(at: IndexPath(row: 0, section: 0))
            XCTAssertEqual(cell?.promoMessageLabel.text, "Promo 1", "The promo message should match the mock data")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchData() {
        let expectation = XCTestExpectation(description: "Data fetched and table view reloaded")

        testInstance.dataProvider.fetchData { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 2, "Mock data should have one item")
                expectation.fulfill()
            case .failure:
                XCTFail("Data fetching failed")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

}
