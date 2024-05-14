//
//  ContactsTableViewCell.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 7.05.2024.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var labelNumber: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
