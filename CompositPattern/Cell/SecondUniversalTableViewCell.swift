//
//  SecondUniversalTableViewCell.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 20.11.2021.
//

import UIKit

class SecondUniversalTableViewCell: UITableViewCell {
    @IBOutlet weak var secondTextLabel: UILabel!

    func config(tasks : Task) {
        secondTextLabel.text = tasks.task
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
