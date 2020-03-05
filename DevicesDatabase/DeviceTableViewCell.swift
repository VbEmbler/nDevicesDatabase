//
//  DeviceTableViewCell.swift
//  DevicesDatabase
//
//  Created by Vladimir on 02/03/2020.
//  Copyright © 2020 Embler. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    //Mark: Properties

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var osVersionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
