//
//  RocketsWorkerTests.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 7/2/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import CleanSpaceX
import XCTest

class RocketsWorkerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: RocketsWorker!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupRocketsWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupRocketsWorker()
  {
    sut = RocketsWorker(rocketsWebService: RocketsWebServiceMock())
  }
  
  // MARK: Tests
  
  func testGetRocketsLookup()
  {
      // Given
      let rocketsWebServiceMock = RocketsWebServiceMock()
      let request = Rockets.SpaceX.Request(test: true, sslPinningEnabled: false)
      
      // When
      var looksup: [Rocket]?
      let _ = rocketsWebServiceMock.fetchRockets(request: request).done({ rocketsLookupModel in
          
          looksup = rocketsLookupModel
          // Then
          XCTAssertTrue(rocketsWebServiceMock.isGetRocketsLookupCalled, "The testGetRocketsLookups() method not called in RocketsWebService class")
          XCTAssertEqual(looksup?.first?.rocketType, "rocket", "GetRocketLookups API failed")

      })
  }
}
