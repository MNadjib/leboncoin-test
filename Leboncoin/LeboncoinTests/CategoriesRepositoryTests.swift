//
//  CategoriesRepositoryTests.swift
//  LeboncoinTests
//
//  Created by Nadjib Bellouni on 21/07/2021.
//

import XCTest

class CategoriesRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testRepositoryError() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerError)
        let categoriesRepository = CategoriesRepository(provider)
        categoriesRepository.retrieveData( { result in
            switch result {
            case.failure(let error): XCTAssertEqual(error, .invalidURL, "Should return invalidURL error" )
            case .success( _): XCTAssertTrue(false, "Error case")
            }
        })
    }
    
    func testRepositoryHttpError() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerHttpError)
        let categoriesRepository = CategoriesRepository(provider)
        categoriesRepository.retrieveData( { result in
            switch result {
            case.failure(let error): XCTAssertEqual(error, .httpError400, "Should return httpError400 error" )
            case .success( _): XCTAssertTrue(false, "Error case")
            }
        })
    }
    
    func testRepositoryEmptyData() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerEmptyData)
        let categoriesRepository = CategoriesRepository(provider)
        categoriesRepository.retrieveData( { result in
            switch result {
            case.failure(_): XCTAssertTrue(false, "Error case")
            case .success(let cat):
                XCTAssertEqual(cat.count , 0, "Should return empty array")
            }
        })
    }
    
    
    func testRepositoryData() {
        let provider: NetworkProviderMock = NetworkProviderMock(testCase: .providerData)
        let categoriesRepository = CategoriesRepository(provider)
        categoriesRepository.retrieveData( { result in
            switch result {
            case.failure(_): XCTAssertTrue(false, "Error case")
            case .success(let cats):
                XCTAssertEqual(cats.count , 3, "Should return array with size 3")
                XCTAssertEqual(cats.first!.id , 1, "Should return 1")
                XCTAssertEqual(cats[1].id , 2, "Should return 2")
                XCTAssertEqual(cats.first!.name, "Véhicule", "Should return right name")
                XCTAssertEqual(cats[1].name , "Mode", "Should return right name")
            }
        })
    }

}
