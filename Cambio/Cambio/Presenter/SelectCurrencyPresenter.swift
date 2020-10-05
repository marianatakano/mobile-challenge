//
//  SelectCurrencyPresenter.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

class SelectCurrencyPresenter: SelectCurrencyPresenterProtocol {
    
    var currencyConverterInfrastructure: CurrencyConverterInfrastructureProtocol = CurrencyConverterInfrastructure()
    
    func requestCurrencyData(completionHandler: @escaping ([SelectCurrencyViewModel], PresenterError) -> Void) {
        
        var list: [SelectCurrencyViewModel] = []
        
        currencyConverterInfrastructure.getListCurrency() {
            (resultData, error) -> Void in
            if error == .noError {
                let sortedValues = resultData!.currencies
                let valueOrdered = sortedValues!.sorted(by: {
                    return $0.key < $1.key
                })
                
                valueOrdered.forEach {
                    list.append(SelectCurrencyViewModel(currency: $0.value, initials: $0.key))
            }
                completionHandler(list, .noError)
            } else {
                completionHandler(list, .genericError)
            }
        }
    }

    
    func loadCurrencyData(origin: String?, destiny: String?, value: Double?, completionHandler: @escaping (Double?, PresenterError) -> Void) {
    
        var resultValue = 0.0
        
        currencyConverterInfrastructure.getListCurrencyQuote() { (resultData, error) -> Void in
            if error == .noError {
                resultData?.quotes!.forEach {
                    if "USD\(origin!)" == $0.key {
                    resultValue = value! / $0.value
                    }
                }
            
                resultData?.quotes!.forEach {
                    if "USD\(destiny!)" == $0.key {
                        resultValue = resultValue * $0.value
                    }
                }
                completionHandler(resultValue, .noError)
            } else if error == .genericError || error == .convertionJsonError {
                completionHandler(nil, .genericError)
            }
        }
    }
}
