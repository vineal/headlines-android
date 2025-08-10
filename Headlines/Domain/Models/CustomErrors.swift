//
//  CustomErrors.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//
enum CustomErrors: String, Error {
    case remoteFetchFailed = "Oh oh! Seems like something is not right. Check your internet connection or try again later."
    case dbOpertaionFailure = "Oh oh! Seems like something is not right. Update your app or try reaching out to support."
}
