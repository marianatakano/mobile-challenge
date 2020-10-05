//
//  CurrencyConverterInfrastructureProtocol.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

protocol CurrencyConverterInfrastructureProtocol {
    func getListCurrency(completrionHandler: @escaping (ListCurrencyResponse?, InfraError) -> Void)
    func getListCurrencyQuote(completionHandler: @escaping (ListCurrencyQuoteResponse?, InfraError) -> Void)
}
