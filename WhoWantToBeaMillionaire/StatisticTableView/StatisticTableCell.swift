//
//  TableViewCell.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 07.11.2021.
//

import UIKit

class StatisticTableCell: UITableViewCell {

    @IBOutlet weak var countOfQuestion: UILabel!
    @IBOutlet weak var moneyOfWin: UILabel!
    @IBOutlet weak var dateOfWin: UILabel!
    @IBOutlet weak var backgroundCell: UIView!


    func config (singleStatistic : Statistic){

        countOfQuestion.text = String(singleStatistic.numberOfQuestion)
        moneyOfWin.text = String(singleStatistic.moneyInPurse)
        dateOfWin.text = singleStatistic.date

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCell.backgroundColor = Game.shared.backgroundAll
        countOfQuestion.textColor = .white
        moneyOfWin.textColor = .white
        dateOfWin.textColor = .white


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
