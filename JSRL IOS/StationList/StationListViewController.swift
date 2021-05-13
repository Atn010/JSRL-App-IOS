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
	var toMusicPlayer = true
	var isPlayingSomething = false
	let musicStationList = StationListCreator().StationList()
	
	var trackName = ""
	var trackStation: StationListInfo.Name = .classic
	var trackLogo:UIImage = UIImage.init(named: "Preloadlogo")!
	var bgColor = UIColor.black
	var acColor = UIColor.black
	var opColor = UIColor.white
	
	var playingAt:IndexPath?
	
	let shuffleList: [StationListInfo.Name] = StationListInfo.shuffleList
	
	init() {
		super.init(nibName: "StationListViewController", bundle: Bundle.init(for: StationListViewController.self))
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Constant
	
	
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
	
	@IBAction func ShuffleallStation(_ sender: UIButton) {
		
		trackStation = StationListInfo.Name.shuffle
		bgColor = .black
		acColor = .blue
		
		trackLogo = UIImage.init(named: StationListInfo.Name.classic.rawValue)!
		
		DispatchQueue.main.async {
			self.musicPlayer.userCommandAudioPlaying = false
			self.musicPlayer.playMusic(station: self.shuffleList)
		}
	}
	
}

extension StationListViewController: UITableViewDelegate, UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return musicStationList.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return musicStationList[section].musicStation.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if playingAt != indexPath{
			
			trackStation = musicStationList[indexPath.section].musicStation[indexPath.row].name
			bgColor = .black
			acColor = musicStationList[indexPath.section].musicStation[indexPath.row].accent
			playingAt = indexPath
			
			
			trackLogo = musicStationList[indexPath.section].musicStation[indexPath.row].logo
			
			
			
			self.musicPlayer.userCommandAudioPlaying = false
			DispatchQueue.main.async {
				if self.trackStation == .shuffle{
					self.musicPlayer.playMusic(station: self.shuffleList)
				} else {
					self.musicPlayer.playMusic(station: [self.trackStation])
				}
				
				
			}
			
			//initMiniPlayer(trackName: "Tuning in to: \(trackStation) Station, Please Wait", bgColor: bgColor, acColor: acColor)
			
			
			tableView.reloadData()
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		return musicStationList[section].group
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MusicStationCell
		let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
		
		cell.backgroundColor = UIColor.init(hexString: "#171717")
		
		cell.imageView?.image = musicStationList[indexPath.section].musicStation[indexPath.row].logo
		
		cell.textLabel?.text = musicStationList[indexPath.section].musicStation[indexPath.row].name.rawValue
		cell.textLabel?.textColor = UIColor.init(hexString: "#DDDDDD")
		
		cell.detailTextLabel?.text = musicStationList[indexPath.section].musicStation[indexPath.row].desc.rawValue
		cell.detailTextLabel?.textColor = UIColor.init(hexString: "#CCCCCC")
		/*
		cell.stationImage.image = musicStationList[indexPath.section].musicStation[indexPath.row].logo
		cell.stationImage.backgroundColor = .black
		
		cell.stationName.text = musicStationList[indexPath.section].musicStation[indexPath.row].name.rawValue
		cell.stationPlayingIndicator.animating = false
		cell.stationPlayingIndicator.alpha = 0
		
		if let playAt = playingAt{
			if playAt == indexPath{
				cell.stationPlayingIndicator.alpha = 1
				cell.stationPlayingIndicator.animating = true
			}
		}
		*/
		//musicStationList[indexPath.section].MusicStation[indexPath.row].name
		
		return cell
	}
	
	
}
