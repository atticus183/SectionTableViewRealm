//
//  TransactionCell.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/13/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    var transaction: Transaction? {
        didSet {
            self.payeeLbl.text = transaction?.payee
            self.amountLbl.text = transaction?.amount.formatCurrencyAsString()
            self.dateLbl.text = transaction?.date.formatDateMonthDDYYYY()
        }
    }
    
    lazy var payeeLbl: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.sizeToFit()

        return label
    }()
    
    lazy var amountLbl: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.sizeToFit()
        
        return label
    }()
    
    lazy var dateLbl: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.sizeToFit()

        return label
    }()
    
    let payeeDateSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false

        return sv
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        payeeDateSV.addArrangedSubview(payeeLbl)
        payeeDateSV.addArrangedSubview(dateLbl)
        self.addSubview(amountLbl)
        self.addSubview(payeeDateSV)
        setupLblConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    private func setupLblConstraints() {
        amountLbl.translatesAutoresizingMaskIntoConstraints = false
        payeeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        amountLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -12).isActive = true
        amountLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        payeeDateSV.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12).isActive = true
        payeeDateSV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
