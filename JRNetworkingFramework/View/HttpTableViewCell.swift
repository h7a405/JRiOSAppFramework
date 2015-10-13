//
//  HttpTableViewCell.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 8/10/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class HttpTableViewCell: UITableViewCell {

    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var dataTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
