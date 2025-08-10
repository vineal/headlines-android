//
//  Secrets.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation

enum Secrets {
    static let guardianAPIKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "GUARDIAN_API_KEY") as? String,
              key.isEmpty == false else {
            fatalError("""
            No Guardian API key found.
            Create Config/Secrets.xcconfig and set GUARDIAN_API_KEY.
            """)
        }
        return key
    }()
}
