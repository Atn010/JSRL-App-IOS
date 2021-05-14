//
//  StationListViewController.swift
//  JSRL IOS
//
//  Created by Antonius George S on 13/05/21.
//  Copyright © 2021 Atn010.com. All rights reserved.
//

import UIKit

class StationListViewController: UIViewController {
	
	// MARK: - Object
	let musicPlayer = MusicPlayerObject.shared
	
	// MARK: - Outlet
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Variable
	let musicStationList = StationListCreator().StationList()
	var playingAt:IndexPath?
	
	init() {
		super.init(nibName: "StationListViewController", bundle: Bundle.init(for: StationListViewController.self))
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Constant
	let cellBGColor = UIColor.init(hexString: "#171717")
	let cellTitleColor = UIColor.init(hexString: "#DDDDDD")
	let cellSubtitleColor = UIColor.init(hexString: "#CCCCCC")
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.navigationController?.navigationBar.barStyle = .black
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		
		self.addLeftBarButtonItem(image: UIImage.init(named: "closeButton"), selector: #selector(closeStationList))
		
		self.title = "Stations"
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = UIColor.init(hexString: "#111111")
		tableView.sectionIndexBackgroundColor = .white
	}
	
	@objc func closeStationList(){
		self.dismiss(animated: true, completion: nil)
	}
	
	override var prefersHomeIndicatorAutoHidden: Bool {
		return true
	}
	
	
}

extension StationListViewController: UITableViewDelegate, UITableViewDataSource{
/*
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	*/
	func numberOfSections(in tableView: UITableView) -> Int {
		return musicStationList.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return musicStationList[section].musicStation.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if playingAt != indexPath{
			let station = musicStationList[indexPath.section].musicStation[indexPath.row].name
			self.musicPlayer.userCommandAudioPlaying = false
			DispatchQueue.main.async {
				if station == .shuffle{
					self.musicPlayer.playMusic(station: StationListInfo.shuffleList)
				} else {
					self.musicPlayer.playMusic(station: [station])
				}
			}
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return musicStationList[section].group
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
		
		cell.backgroundColor = cellBGColor
		cell.imageView?.image = musicStationList[indexPath.section].musicStation[indexPath.row].logo
		
		cell.textLabel?.text = musicStationList[indexPath.section].musicStation[indexPath.row].name.rawValue
		cell.textLabel?.textColor = cellTitleColor
		cell.detailTextLabel?.numberOfLines = 1
		
		cell.detailTextLabel?.text = musicStationList[indexPath.section].musicStation[indexPath.row].desc.rawValue
		cell.detailTextLabel?.textColor = cellSubtitleColor
		cell.detailTextLabel?.numberOfLines = 1
		
		
		
		if musicStationList[indexPath.section].musicStation[indexPath.row].name == musicPlayer.currentStation {
			self.playingAt = indexPath
			cell.accessoryType = .checkmark
		}
		return cell
	}
	
	
}
