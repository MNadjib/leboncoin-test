//
//  RepositoriesTests.swift
//  LeboncoinTests
//
//  Created by Nadjib Bellouni on 21/07/2021.
//

import XCTest

class ClassifiedAdsRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoryError() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerError)
        let classifiedAdsRepository = ClassifiedAdsRepository(provider)
        classifiedAdsRepository.retrieveData( { result in
            switch result {
            case.failure(let error): XCTAssertEqual(error, .invalidURL, "Should return invalidURL error" )
            case .success( _): XCTAssertTrue(false, "Error case")
            }
        })
    }
    
    func testRepositoryHttpError() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerHttpError)
        let classifiedAdsRepository = ClassifiedAdsRepository(provider)
        classifiedAdsRepository.retrieveData( { result in
            switch result {
            case.failure(let error): XCTAssertEqual(error, .httpError400, "Should return httpError400 error" )
            case .success( _): XCTAssertTrue(false, "Error case")
            }
        })
    }
    
    func testRepositoryEmptyData() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerEmptyData)
        let classifiedAdsRepository = ClassifiedAdsRepository(provider)
        classifiedAdsRepository.retrieveData( { result in
            switch result {
            case.failure(_): XCTAssertTrue(false, "Error case")
            case .success(let ads):
                XCTAssertEqual(ads.count , 0, "Should return empty array")
            }
        })
    }
    
    
    func testRepositoryData() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerData)
        let classifiedAdsRepository = ClassifiedAdsRepository(provider)
        classifiedAdsRepository.retrieveData( { result in
            switch result {
            case.failure(_): XCTAssertTrue(false, "Error case")
            case .success(let ads):
                XCTAssertEqual(ads.count , 2, "Should return array with size 2")
                XCTAssertEqual(ads.first!.id , 1461267313, "Should return 1461267313")
                XCTAssertEqual(ads[1].id , 1691247255, "Should return 1691247255")
                XCTAssertEqual(ads.first!.title, "Statue homme noir assis en plâtre polychrome", "Should return right title")
                XCTAssertEqual(ads[1].title , "Pc portable hp elitebook 820 g1 core i5 4 go ram 250 go hdd", "Should return right title")
            }
        })
    }
}
