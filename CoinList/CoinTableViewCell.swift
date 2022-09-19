//
//  CoinTableViewCell.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import UIKit
import SDWebImage

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var percentageView: PercentageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinIconImageView: UIImageView!
    @IBOutlet weak var tuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populate(coin: CoinListResponse.Coin) {
        self.indexLabel.text = String(coin.r ?? 0)
        self.coinNameLabel.text = coin.n ?? ""
        self.tuLabel.text = coin.s
        if let amount = coin.pu {
           self.priceLabel.text = amount.currencyString
        }

        if let p1 = coin.p1 {
            if p1 > 0 {
                percentageView.increased = true
            } else {
                percentageView.increased = false
            }
            self.percentageView.textLabel.text = String(p1) + "%"
        }
        coinIconImageView.sd_setImage(with: URL(string: coin.ic ?? ""))
    }

}
