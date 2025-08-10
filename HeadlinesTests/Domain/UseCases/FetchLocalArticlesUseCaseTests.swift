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
    func testUsecase_whenRepositoryFails_ShouldReturnErrorInCompletion() throws {
        let sut: FetchLocalArticlesUseCaseProtocol =  FetchLocalArticlesUseCase()
        let expectation = XCTestExpectation(description: "Wait for completion")
        sut.fetchArticles { articles, error in
            expectation.fulfill()
            XCTAssertNil(articles)
            XCTAssertEqual(error as? CustomErrors, CustomErrors.dbOpertaionFailure)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Update your app or try reaching out to support.")
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
