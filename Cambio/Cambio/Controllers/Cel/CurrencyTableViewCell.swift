//
//  CurrencyTableViewCell.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    lazy var initialsLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var currencyLabel: UILabel = {
        return UILabel()
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
//        viewCodeSetup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewCodeSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CurrencyTableViewCell: ViewCodeProtocol {

    func viewCodeHierarchySetup() {
        addSubview(initialsLabel)
        addSubview(currencyLabel)
    }
    
    func viewCodeConstraintSetup() {
        
        initialsLabel.snp.makeConstraints { (mkr) in
            mkr.top.left.right.equalToSuperview()
            mkr.height.equalTo(30)
        }
        
        currencyLabel.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(initialsLabel.snp.bottom)
            mkr.bottom.left.right.equalToSuperview()
            mkr.height.equalTo(30)
        }
    }
    
    func viewCodeSetup() {
        
        initialsLabel.font = .boldSystemFont(ofSize: 12)
        initialsLabel.textColor = .purple
        initialsLabel.lineBreakMode = .byWordWrapping
        initialsLabel.numberOfLines = 0
        
        currencyLabel.font = .boldSystemFont(ofSize: 12)
        currencyLabel.textColor = .black
        currencyLabel.lineBreakMode = .byWordWrapping
        currencyLabel.numberOfLines = 0
    }
    

}
