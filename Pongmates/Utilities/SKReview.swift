//
//  SKReview.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 16.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import StoreKit

class SKReview {
    
    // MARK: - Types
    
    static let shared = SKReview()
    
    // MARK: - Methods
    
    // Request a review.
    func requestReviewIfAppropriate() {
        let bundleVersionKey = kCFBundleVersionKey as String
        let bundleVersion = Bundle.main.object(forInfoDictionaryKey: bundleVersionKey) as? String
        
        let applicationLaunches = Defaults.shared.applicationLaunches
        let lastBundleVersion = Defaults.shared.lastBundleVersion
        
        if applicationLaunches >= 2 {
            if lastBundleVersion != bundleVersion {
                Defaults.shared.applicationLaunches = 0
                Defaults.shared.lastBundleVersion = bundleVersion
                
                SKStoreReviewController.requestReview()
            }
        }
    }
    
}
