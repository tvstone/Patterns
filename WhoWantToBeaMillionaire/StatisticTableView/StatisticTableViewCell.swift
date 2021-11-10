//
//  StatisticTableViewCell.swift
//  WhoWantToBeaMillionaire
//
//  Created by Владислав Тихоненков on 07.11.2021.
//

import UIKit


class StatisticTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfQuestion: UILabel!
    @IBOutlet weak var moneyOfWinn: UILabel!
    @IBOutlet weak var dateOfPlay: UILabel!

    
    func clearNewsCell() {

        numberOfQuestion = nil
        moneyOfWinn = nil
        dateOfPlay = nil

    }

    override func prepareForReuse() {
        clearNewsCell()
    }

    func config (singleStatistic : Statistic){

        let date = singleStatistic.date
        let number = String(singleStatistic.numberOfQuestion)
        let money = String(singleStatistic.moneyInPurse)
        dateOfPlay.text = date
        numberOfQuestion.text = number
        moneyOfWinn.text = money


    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clearNewsCell()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
