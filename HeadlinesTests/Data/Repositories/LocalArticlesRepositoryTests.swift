//
//  LocalArticlesRepositoryTests.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import XCTest

@testable import Headlines

final class LocalArticlesRepositoryTests: XCTestCase {
    var serviceSpy: LocalServiceSpy!
    
    override func tearDown() {
        serviceSpy = nil
    }
    
    func testRepository_whenServiceFails_shouldThrowError() {
        serviceSpy = LocalServiceSpy(
            shouldThrowError: true
        )
        let sut: LocalArticlesRepositoryProtocol = LocalArticlesRepository(service: serviceSpy)
        do {
            try sut.saveArticles(TestFixtures.articles)
        } catch {
            XCTAssertEqual(error as? CustomErrors, CustomErrors.dbOpertaionFailure)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Update your app or try reaching out to support.")
        }
    }
    
    func testUsecase_whenServiceSucceed_ShouldSaveArticles() throws {
        serviceSpy = LocalServiceSpy(
            shouldThrowError: false
        )
        let sut: LocalArticlesRepository = LocalArticlesRepository(
            service: serviceSpy
        )
        do {
            try sut.saveArticles(TestFixtures.articles)
            XCTAssertEqual(self.serviceSpy?.saveArticlesCounter, 1)
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
