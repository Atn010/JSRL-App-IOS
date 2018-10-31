//
//  MusicStationCell.swift
//  JSRL IOS
//
//  Created by Antonius George on 29/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class MusicStationCell: UITableViewCell {

	@IBOutlet weak var stationImage: UIImageView!
	@IBOutlet weak var stationName: UILabel!
	@IBOutlet weak var stationPlayingIndicator: UIImageView!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
