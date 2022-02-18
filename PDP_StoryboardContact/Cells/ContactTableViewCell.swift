//
//  ContactTableViewCell.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 19/02/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var LastBackgroundView: UIView!
    @IBOutlet weak var UpperBackgroundView: UIView!
    @IBOutlet weak var ColouredBackgroundView: UIView!
    @IBOutlet weak var TopBackgrounView: UIView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initModifiedViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initModifiedViews() {
        LastBackgroundView.layer.cornerRadius = 13.0
        UpperBackgroundView.layer.cornerRadius = 13.0
        ColouredBackgroundView.layer.cornerRadius = 13.0
        TopBackgrounView.layer.cornerRadius = 13.0
    }
    
}
