//
//  AddTransactionView.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/15/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit

class AddTransactionView: UIView {
    
    //view components
    lazy var amountTxt: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textField.textColor = .white
        let placeHolderTextColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.7293717894)
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Amount",
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeHolderTextColor])
        textField.font = UIFont.systemFont(ofSize: 48, weight: .medium)
        textField.textAlignment = .right
        
        return textField
    }()
    
    lazy var payeeTxt: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textField.textColor = .white
        let placeHolderTextColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.7293717894)
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Payee",
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeHolderTextColor])
        textField.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        textField.textAlignment = .right
        
        return textField
    }()
    
    lazy var tranDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        picker.calendar = .current
        picker.datePickerMode = .dateAndTime
        
        picker.backgroundColor = .white
        return picker
    }()
    
    let sv: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fillProportionally
        
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.roundCorners(by: 15)
        addCompentsToView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addCompentsToView() {
        
        addViewsToSV(amountTxt, payeeTxt, tranDatePicker)
        self.addSubview(sv)
        
        setConstraints()
    }
    
    private func addViewsToSV(_ views: UIView...) {
        views.forEach({ sv.addArrangedSubview($0) })
    }
    
    private func setConstraints() {
        amountTxt.translatesAutoresizingMaskIntoConstraints = false
        payeeTxt.translatesAutoresizingMaskIntoConstraints = false
        tranDatePicker.translatesAutoresizingMaskIntoConstraints = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        amountTxt.heightAnchor.constraint(equalToConstant: 75).isActive = true
        payeeTxt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tranDatePicker.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        sv.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
    }
    
}
