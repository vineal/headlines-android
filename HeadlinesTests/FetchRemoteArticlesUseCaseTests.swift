//
//  FetchRemoteArticlesUseCaseTests.swift
//  HeadlinesTests
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class FetchRemoteArticlesUseCaseTests: XCTestCase {
    
    func testUsecase_whenRepositoryFails_ShouldReturnErrorInCompletion() throws {
        let sut: FetchRemoteArticlesUseCaseProtocol = FetchRemoteArticlesUseCase()
        sut.fetchArticles { _, error in
            XCTAssertEqual(error as? CustomErrors, CustomErrors.remoteFetchFailed)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Check your internet connection or try again later.")
        }
    }
}
