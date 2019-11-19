//
//  AddBtn.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/14/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit

class AddBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: 225, height: 50)
        self.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.titleLabel!.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.giveRoundCorners()
        self.layer.masksToBounds = true
        setupBtnShadow()
    }
    
    private func setupBtnShadow() {
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = 4
        layer.masksToBounds = false  //required
    }
    
    

}
