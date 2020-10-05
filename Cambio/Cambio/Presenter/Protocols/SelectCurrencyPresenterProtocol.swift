//
//  SelectCurrencyPresenterProtocol.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

protocol SelectCurrencyPresenterProtocol {
    func requestCurrencyData(completionHandler: @escaping ([SelectCurrencyViewModel], PresenterError) -> Void)
    func loadCurrencyData(origin: String?, destiny: String?, value: Double?, completionHandler: @escaping (Double?, PresenterError) -> Void)
}
