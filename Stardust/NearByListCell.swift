//
//  NearByListCell.swift
//  Stardust
//
//  Created by shikata hiroshi on 2017/03/04.
//  Copyright © 2017年 Stardust. All rights reserved.
//

import UIKit

class NearByListCell: UITableViewCell {
    @IBOutlet weak var personIconImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var twitterAccountNameLabel: UILabel!
    @IBOutlet weak var topicLabelStacView: UIStackView!
    
    @IBOutlet weak var meetsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personIconImageView.layer.cornerRadius = personIconImageView.frame.size.width * 0.5
        personIconImageView.clipsToBounds = true;
        personIconImageView.layer.borderWidth = 0.5
    }
}

extension NearByListCell {
    static var cellIdentifier:String {
        return "NearByListCell"
    }
    
    static var nib:UINib {
        let nib = UINib.init(nibName: cellIdentifier, bundle: nil)
        return nib
    }
}
