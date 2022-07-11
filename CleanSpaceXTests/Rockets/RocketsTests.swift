//
//  RocketsTests.swift
//  RocketsTests
//
//  Created by Ahmed Iqbal on 8/18/21.
//

import XCTest
@testable import CleanSpaceX

class RocketsTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: RocketsViewController!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: RocketsViewController.self)) as? RocketsViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        storyboard = nil
    }

    func testRocketsViewController_WhenCreated_HasTableViewProtocolsRegistered() throws {
        // Arrange
        let tableView: UITableView = try XCTUnwrap(sut.tableView, "tableView does not have a referencing outlet")
        let tableViewDelegate = try XCTUnwrap(tableView.delegate, "RocketsViewController's tableView delegate is nil")
        let tableViewDataSource = try XCTUnwrap(tableView.dataSource, "RocketsViewController's tableView datasource is nil")
        
        // Act

        // Assert
        XCTAssertTrue(tableViewDelegate.isKind(of: RocketsViewController.self), "RocketsViewController is not injected to tableView as delegate")
        XCTAssertTrue(tableViewDataSource.isKind(of: RocketsViewController.self), "RocketsViewController is not injected to tableView as dataSource")
    }
    
    func testRocketsViewController_WhenCreated_HasTableViewCellsRegistered() throws {
        // Arrange
        let tableView: UITableView = try XCTUnwrap(sut.tableView, "tableView does not have a referencing outlet")
        
        // Act
        let registeredCellClasses = tableView.value(forKey: "_cellClassDict") as? [String:Any]
        
        // Assert
        XCTAssertNotNil(registeredCellClasses?.contains(where: {($0.key == "RocketsCell")}), "RocketsCell is not registered with tableView")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
