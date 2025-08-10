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
    func testRepository_whenServiceFails_shouldReturnError() {
        let sut: RemoteArticlesRepositoryProtocol = RemoteArticlesRepository()
        sut.fetchArticles { articles, error in
            XCTAssertNil(articles)
            XCTAssertEqual(error as? CustomErrors, CustomErrors.remoteFetchFailed)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Check your internet connection or try again later.")
        }
    }
}
