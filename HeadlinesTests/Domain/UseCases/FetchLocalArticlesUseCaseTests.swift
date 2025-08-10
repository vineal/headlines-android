//
//  FetchLocalArticlesUseCaseTests.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class FetchLocalArticlesUseCaseTests: XCTestCase {
    var repositorySpy: LocalRepositorySpy!
    
    override func tearDown() {
        repositorySpy = nil
    }
    
    func testUsecase_whenRepositoryFails_ShouldReturnErrorInCompletion() throws {
        repositorySpy = LocalRepositorySpy(
            shouldThrowError: true
        )
        let sut: FetchLocalArticlesUseCaseProtocol = FetchLocalArticlesUseCase(
            localRepository: repositorySpy
        )
        let expectation = XCTestExpectation(description: "Wait for completion")
        sut.fetchArticles { articles, error in
            expectation.fulfill()
            XCTAssertTrue(((articles?.isEmpty) != nil))
            XCTAssertEqual(error as? CustomErrors, CustomErrors.dbOpertaionFailure)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Update your app or try reaching out to support.")
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testUsecase_whenRepositorySucceed_ShouldReturnArticles() throws {
        repositorySpy = LocalRepositorySpy(
            shouldThrowError: false
        )
        let sut: FetchLocalArticlesUseCaseProtocol = FetchLocalArticlesUseCase(
            localRepository: repositorySpy
        )
        let expectation = XCTestExpectation(description: "Wait for completion")
        sut.fetchArticles { [weak self] articles , error in
            expectation.fulfill()
            XCTAssertNil(error)
            if let articles {
                XCTAssertNotNil(articles)
                XCTAssertEqual(self?.repositorySpy?.fetchArticlesCounter, 1)
            } else {
                XCTFail("Should have got articles")
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
