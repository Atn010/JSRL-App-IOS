//
//  StationListVC.swift
//  JSRL IOS
//
//  Created by Antonius George on 29/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class StationListVC: UIViewController {
	

	// MARK: - Outlet
	@IBOutlet weak var stationList: UITableView!
	@IBOutlet weak var miniPlayer: UIView!
	
	@IBOutlet weak var skipNextOutlet: UIButton!
	@IBOutlet weak var trackProgressBar: UIProgressView!
	@IBOutlet weak var songNameScrollText: ScrollText!
	@IBOutlet weak var miniPlayerBottom: NSLayoutConstraint!
	@IBOutlet weak var bottomCover: UIView!
	
	// MARK: - Variable
	var toMusicPlayer = true
	
	override func viewDidLoad() {
        super.viewDidLoad()
		stationList.delegate = self
		stationList.dataSource = self
		
		miniPlayerBottom.constant = -100
		
		
		let open = UITapGestureRecognizer(target: self, action: #selector(openPlayer))
		
		songNameScrollText.addGestureRecognizer(open)
		//stationList.rowHeight = 58
		//stationList.backgroundColor = .black
		
		
        // Do any additional setup after loading the view.
    }
	func initMiniPlayer(trackName:String, bgColor:UIColor,acColor:UIColor){
		songNameScrollText.destroy()
		var tnColor = UIColor.purple
		if bgColor != .black{
			tnColor = UIColor.black
		}else{
			tnColor = UIColor.white
		}
		
		trackProgressBar.progress = 0.3
		trackProgressBar.tintColor = acColor
		
		skipNextOutlet.tintColor = tnColor
		
		songNameScrollText.setup(text: trackName, BackgroundColor: bgColor, TextColor: tnColor)
		
		bottomCover.backgroundColor = bgColor
		
	}
	
	@objc func openPlayer(){
		performSegue(withIdentifier: "toPlayer", sender: self)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StationListVC: UITableViewDelegate, UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 8
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if miniPlayerBottom.constant != 0{
			miniPlayerBottom.constant = 0
			UIView.animate(withDuration: 0.3) {
				self.view.layoutIfNeeded()
			}
		}
		
		if indexPath.row == 0 {
			initMiniPlayer(trackName: "Daft Punk - One More Time (Frenssu Remix)", bgColor: .black, acColor: .yellow)
		}else if indexPath.row == 1 {
			initMiniPlayer(trackName: "Gogol Bordello vs Tamir Muskat - Balkanization of Amerikanization", bgColor: .black, acColor: .red)
		}else{
			initMiniPlayer(trackName: "Guitar Vader - I Love Love You (Love Love Super Dimension Mix)", bgColor: .black, acColor: .green)
		}
		
		
		//initMiniPlayer(trackName: "Daft Bunk - Lolz", bgColor: .black, acColor: .green)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MusicStationCell
		//cell.objectName.text = tableObjectArray[indexPath.section].card[indexPath.row].name
		cell.stationName.text = "Classic"
		return cell
	}
	
	
}
