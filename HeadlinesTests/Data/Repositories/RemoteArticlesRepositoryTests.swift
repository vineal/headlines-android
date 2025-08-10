//
//  RemoteArticlesRepositoryTests.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest

@testable import Headlines

final class RemoteArticlesRepositoryTests: XCTestCase {
    var serviceSpy: RemoteArticlesServiceSpy!
    
    override func tearDown() {
        serviceSpy = nil
    }
    
    func testRepository_whenServiceFails_shouldReturnError() {
        serviceSpy = RemoteArticlesServiceSpy(completeWithError: true)
        let sut: RemoteArticlesRepositoryProtocol = RemoteArticlesRepository(
            service: serviceSpy
        )
        sut.fetchArticles { articles, error in
            XCTAssertNil(articles)
            XCTAssertEqual(error as? CustomErrors, CustomErrors.remoteFetchFailed)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Check your internet connection or try again later.")
        }
    }
    
    func testRepository_whenServiceSucceed_ShouldReturnArticles() throws {
        serviceSpy = RemoteArticlesServiceSpy(completeWithError: false)
        let sut: RemoteArticlesRepositoryProtocol = RemoteArticlesRepository(
            service: serviceSpy
        )
        sut.fetchArticles { [weak self] articles , error in
            XCTAssertNil(error)
            if let articles {
                XCTAssertNotNil(articles)
                XCTAssertEqual(self?.serviceSpy?.fetchArticlesCalledCount, 1)
            } else {
                XCTFail("Should have got articles")
            }
        }
    }
}
