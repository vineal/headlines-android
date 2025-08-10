//
//  SaveArticlesInDBUseCaseTests.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class SaveArticlesInDBUseCaseTests: XCTestCase {
    var repositorySpy: LocalRepositorySpy!
    
    override func tearDown() {
        repositorySpy = nil
    }
    
    func testUsecase_whenRepositoryFails_ShouldThrowError() throws {
        repositorySpy = LocalRepositorySpy(
            shouldThrowError: true
        )
        let sut: SaveArticlesInDBUseCaseProtocol =  SaveArticlesInDBUseCase(localRepository: repositorySpy)
        
        do {
            try sut.saveArticles(TestFixtures.articles)
        } catch {
            XCTAssertEqual(error as? CustomErrors, CustomErrors.dbOpertaionFailure)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Update your app or try reaching out to support.")
        }
    }
    
    func testUsecase_whenRepositorySucceed_ShouldReturnArticles() throws {
        repositorySpy = LocalRepositorySpy(
            shouldThrowError: false
        )
        let sut: SaveArticlesInDBUseCaseProtocol = SaveArticlesInDBUseCase(
            localRepository: repositorySpy
        )
        do {
            try sut.saveArticles(TestFixtures.articles)
            XCTAssertEqual(self.repositorySpy?.saveArticlesCounter, 1)
        } catch {
            XCTFail("Expected to save, but got an error")
        }
    }
    
    // MARK: - Test helpers
    private struct TestFixtures {
        private static let fixedDate = Date(timeIntervalSince1970: 1_640_995_200)
        static let articles: [Article] = [
            Article(headline: "Headline1", body: "Body1", published: fixedDate, rawImageURL: "URL")!
        ]
    }
}
