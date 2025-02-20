//
//  TextViewCell.swift
//  TesteiOS
//
//  Created by Erika de Almeida Segatto on 18/08/19.
//  Copyright © 2019 Erika de Almeida Segatto. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialButtons
import Domain

class TextViewCell: UITableViewCell, FormViewCell {
    
    
    @IBOutlet var label: UILabel!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    
    private var id: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // theming
        let theme = ThemeManager.current()
        label.font = theme.formFieldFont
        label.textColor = theme.formFieldTextColor
    }
    
    func configure(id: Int, message: String, fieldType: FieldType, userInput: Any?, enabled: Bool, hidden: Bool, topSpacing: Double, delegate: FormViewCellDelegate?) {
        self.id = id
        label.text = message
        
        label.isHidden = hidden
        
        topConstraint.constant = CGFloat(topSpacing)
    }
    
    
}
