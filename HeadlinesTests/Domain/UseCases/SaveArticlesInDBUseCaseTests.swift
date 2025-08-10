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
    
    func testUsecase_whenRepositoryFails_ShouldThrowError() throws {
        let fixedDate = Date(timeIntervalSince1970: 1_640_995_200)
        let articles: [Article] = [
            Article(headline: "Headline1", body: "Body1", published: fixedDate, rawImageURL: "URL")!
        ]

        let sut: SaveArticlesInDBUseCaseProtocol =  SaveArticlesInDBUseCase()
        
        do {
            try sut.saveArticles(articles)
        } catch {
            XCTAssertEqual(error as? CustomErrors, CustomErrors.dbOpertaionFailure)
            XCTAssertEqual((error as? CustomErrors)?.rawValue, "Oh oh! Seems like something is not right. Update your app or try reaching out to support.")
        }
    }
}
