//
//  AdminPanelTableViewCell.swift
//  CollageMateFirebaseApp
//
//  Created by vinus on 06/09/17.
//  Copyright © 2017 vinus. All rights reserved.
//

import UIKit

class AdminPanelTableViewCell: UITableViewCell {

    @IBOutlet weak var lableName: UILabel!
    
    @IBOutlet weak var labelTypeOfUser: UILabel!
    
    override func awakeFromNib() {
                super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
