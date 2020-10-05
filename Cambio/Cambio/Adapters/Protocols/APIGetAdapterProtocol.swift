//
//  APIGetAdapterProtocol.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

protocol APIGetAdapterProtocol {
    func getSimpleAPI(url: String, completrionHandler: @escaping (Data?, AdapterError) -> Void)
}
