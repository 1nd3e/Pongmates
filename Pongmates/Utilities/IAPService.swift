//
//  IAPService.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 16.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import UIKit
import StoreKit

protocol IAPServiceDelegate {
    func adsDidDisabled()
}

class IAPService: NSObject {
    
    // MARK: - Types
    
    static let shared = IAPService()
    
    // MARK: - Properties
    
    var delegate: IAPServiceDelegate?
    
    // MARK: - Methods
    
    // Создаёт наблюдатель за транзакциями в In-App Purchases
    func addObserver() {
        SKPaymentQueue.default().add(self)
    }
    
    // Удаляет наблюдатель за транзакциями в In-App Purchases
    func removeObserver() {
        SKPaymentQueue.default().remove(self)
    }
    
    // Отправляет запрос на покупку отключения рекламы
    func removeAds() {
        guard SKPaymentQueue.canMakePayments() else { return }
        
        let payment = SKMutablePayment()
        payment.productIdentifier = "ru.1nd3e.Pongmates.Ads"
        
        SKPaymentQueue.default().add(payment)
    }
    
    // Отправляет запрос на восстановление покупок
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}

// MARK: - SKPaymentTransactionObserver

extension IAPService: SKPaymentTransactionObserver {
    
    // Обрабатывает состояния транзакций
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                // Сообщаем делегату о завершении транзакции
                delegate?.adsDidDisabled()
                
                // Сохраняем статус транзакции в UserDefaults
                Defaults.shared.adsDisabled = true
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                if let error = transaction.error {
                    print(error.localizedDescription)
                }
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                // Сообщаем делегату о завершении восстановления покупок
                delegate?.adsDidDisabled()
                
                // Сохраняем статус транзакции в UserDefaults
                Defaults.shared.adsDisabled = true
            default:
                break
            }
        }
    }
    
}
