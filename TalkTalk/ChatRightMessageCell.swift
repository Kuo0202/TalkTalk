//
//  ChatRightMessageCell.swift
//  TalkTalk
//
//  Created by PeterKuo on 2022/3/23.
//

import UIKit

class ChatRightMessageCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
}
