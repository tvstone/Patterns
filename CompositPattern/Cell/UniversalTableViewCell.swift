//
//  UniversalTableViewCell.swift
//  CompositPattern
//
//  Created by Владислав Тихоненков on 18.11.2021.
//

import UIKit

class UniversalTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!

    func config(tasks : String) {
        taskLabel.text = tasks
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
