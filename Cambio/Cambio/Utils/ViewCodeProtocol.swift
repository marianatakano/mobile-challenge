//
//  ViewCodeProtocol.swift
//  Cambio
//
//  Created by Mariana Takano on 04/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

protocol ViewCodeProtocol: class {
    func viewCodeSetup()
    func viewCodeHierarchySetup()
    func viewCodeConstraintSetup()
    func viewCodeThemeSetup()
    func viewCodeAdditionalSetup()
}

extension ViewCodeProtocol {
    
    func viewCodeSetup() {
        viewCodeHierarchySetup()
        viewCodeConstraintSetup()
        viewCodeThemeSetup()
        viewCodeAdditionalSetup()
    }
    
    func viewCodeThemeSetup() {}
    
    func viewCodeAdditionalSetup() {}
}
