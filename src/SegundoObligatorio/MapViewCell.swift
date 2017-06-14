//
//  MapViewCell.swift
//  SegundoObligatorio
//
//  Created by Gonzalo Barrios on 13/6/17.
//  Copyright © 2017 Universidad Catolica. All rights reserved.
//

import UIKit

class MapViewCell: UITableViewCell {

    @IBOutlet weak var locationIconImg: UIImageView!
    @IBOutlet weak var useActLocationLbl: UILabel!
    @IBOutlet weak var actualLocationSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
