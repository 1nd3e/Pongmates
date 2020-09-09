//
//  IAPService.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 16.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import StoreKit

protocol IAPServiceDelegate: class {
    func adsDidDisabled()
}

class IAPService: NSObject {
    
    // MARK: - Types
    
    static let shared = IAPService()
    
    // MARK: - Properties
    
    weak var delegate: IAPServiceDelegate?
    
    // MARK: - Methods
    
    // Adds an observer for transactions in In-App Purchases.
    func addObserver() {
        SKPaymentQueue.default().add(self)
    }
    
    // Removes an observer for transactions in In-App Purchases.
    func removeObserver() {
        SKPaymentQueue.default().remove(self)
    }
    
    // Sends a request for purchase of removing ads.
    func removeAds() {
        guard SKPaymentQueue.canMakePayments() else { return }
        
        let payment = SKMutablePayment()
        payment.productIdentifier = "ru.1nd3e.Pongmates.Ads"
        
        SKPaymentQueue.default().add(payment)
    }
    
    // Sends a request to restore purchases.
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}

// MARK: - SKPaymentTransactionObserver

extension IAPService: SKPaymentTransactionObserver {
    
    // Processes transaction states.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                delegate?.adsDidDisabled()
                Defaults.shared.adsDisabled = true
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                if let error = transaction.error {
                    print(error.localizedDescription)
                }
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                delegate?.adsDidDisabled()
                Defaults.shared.adsDisabled = true
            default:
                break
            }
        }
    }
    
}
