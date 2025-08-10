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
    var repositorySpy: RemoteRepositorySpy!
    
    override func tearDown() {
        repositorySpy = nil
    }
    
    func testUsecase_whenRepositoryFails_ShouldReturnErrorInCompletion() throws {
        repositorySpy = RemoteRepositorySpy(
            shouldReturnArticles: false
        )
        let sut: FetchRemoteArticlesUseCaseProtocol =  FetchRemoteArticlesUseCase(
            remoteRepository: repositorySpy
        )
        sut.fetchArticles { articles, error in
            XCTAssertNil(articles)
            XCTAssertEqual(error as? CustomErrors, CustomErrors.remoteFetchFailed)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Check your internet connection or try again later.")
        }
    }
    
    func testUsecase_whenRepositorySucceed_ShouldReturnArticles() throws {
        repositorySpy = RemoteRepositorySpy(
            shouldReturnArticles: true
        )
        let sut: FetchRemoteArticlesUseCaseProtocol = FetchRemoteArticlesUseCase(
            remoteRepository: repositorySpy
        )
        sut.fetchArticles { [weak self] articles , error in
            XCTAssertNil(error)
            if let articles {
                XCTAssertNotNil(articles)
                XCTAssertEqual(self?.repositorySpy?.fetchArticlesCounter, 1)
            } else {
                XCTFail("Should have got articles")
            }
        }
    }
}
