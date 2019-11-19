//
//  TransactionHeaderView.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/17/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit

class TransactionHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLbl: UILabelWithPadding = {
        let label = UILabelWithPadding()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = .center
        label.layer.masksToBounds = true
        
        //label padding
        label.widthPadding = 15
        label.heighPadding = 4
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        viewSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewSetup()
    }
    
    private func viewSetup() {
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addViews(views: titleLbl)
        setConstraints()
    }
    
    private func addViews(views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
    
    private func setConstraints() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
