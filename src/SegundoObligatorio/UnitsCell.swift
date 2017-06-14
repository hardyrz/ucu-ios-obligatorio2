//
//  UnitsCell.swift
//  SegundoObligatorio
//
//  Created by Gonzalo Barrios on 13/6/17.
//  Copyright © 2017 Universidad Catolica. All rights reserved.
//

import UIKit

class UnitsCell: UITableViewCell {
    
    @IBOutlet weak var rulerImage: UIImageView!
    @IBOutlet weak var unidadesLabel: UILabel!
    @IBOutlet weak var unitsSelector: UISegmentedControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
