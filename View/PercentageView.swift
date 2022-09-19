//
//  PercentageView.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 19/09/2022.
//

import UIKit

class PercentageView: UIView {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "down")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    var textLabel: UILabel = {
       let text = UILabel()
       text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
       return text
    }()

var increased: Bool = false {
    didSet {
        if increased {
            self.backgroundColor = UIColor(red: 0.204, green: 0.702, blue: 0.286, alpha: 0.1)
            imageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
            imageView.tintColor = UIColor(red: 0.204, green: 0.702, blue: 0.286, alpha: 1)
            textLabel.textColor = UIColor(red: 0.204, green: 0.702, blue: 0.286, alpha: 1)
        } else {
            self.backgroundColor =  UIColor(red: 0.941, green: 0.161, blue: 0.204, alpha: 0.1)
            imageView.transform = CGAffineTransform.identity
            imageView.tintColor = UIColor(red: 0.941, green: 0.161, blue: 0.204, alpha: 1)
            textLabel.textColor = .red
        }
        self.setNeedsLayout()
    }
}

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 10)
        ])
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "12"
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            textLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            textLabel.heightAnchor.constraint(equalToConstant: 20),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])

    }

}
