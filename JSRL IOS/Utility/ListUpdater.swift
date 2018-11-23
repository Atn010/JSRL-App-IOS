//
//  ListUpdater.swift
//  JSRL IOS
//
//  Created by Antonius George on 02/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class ListUpdater: NSObject {
	
	let dateNow = Date()
	
	// Base URL Path
	let jetsetradio = "https://jetsetradio.live/"
	let stationPath = "audioplayer/stations/"
	let listPath = "/~list.js"
	
	// Station Playlist Path
	//Station Bumps
	let bumpPath = "bumps"
	
	//Soundtrack
	let classicPath = "classic"
	let futurePath = "future"
	
	//Seasonal
	let summerPath = "summer"
	let christmasPath = "christmas"
	
	//Gang
	let ggsPath = "ggs"
	let poisonJamPath = "poisonjam"
	let noiseTanksPath = "noisetanks"
	let loveShockersPath = "loveshockers"
	let rapid99Path = "rapid99"
	let theImmortalsPath = "immortals"
	let doomRidersPath = "doomriders"
	let goldenRhinosPath = "goldenrhinos"
	
	
	// Station Name
	//Station Bumps
	let bump = "Bump"
	
	//Soundtrack
	let classic = "Classic"
	let future = "Future"
	
	//Seasonal
	let summer = "Summer"
	let christmas = "Christmas"
	
	//Gang
	let ggs = "GG's"
	let poisonJam = "Poison Jam"
	let noiseTanks = "Noise Tanks"
	let loveShockers = "Love Shockers"
	let rapid99 = "Rapid 99"
	let theImmortals = "The Immortals"
	let doomRiders = "Doom Riders"
	let goldenRhinos = "Golden Rhinos"
	
	var updateList:[String:String] = [:]
	
	static let shared = ListUpdater()
	
	override private init() {
		
	}
	
	func checkForUpdate(){
		if let dataDate = UserDefaults.standard.object(forKey: "date") as? Date {
			if daysBetweenDates(startDate: dataDate, endDate: dateNow) >= 1{
				getAndUpdateList()
			}
		}else{
			getAndUpdateList()
		}
	}
	
	func getAndUpdateList() {
		updateList = loadUpdateList()
		
		for (key,value) in updateList{
			downloadList(fileUrl: "\(jetsetradio)\(stationPath)\(value)\(listPath)", fileKey: key)
		}
		
		
	}
	
	func downloadList(fileUrl:String, fileKey:String){
		let url = URL(string: fileUrl)!
		var fileList:[String] = []
		
		
		DispatchQueue.global(qos: .userInitiated).sync {
			URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
				
				if let isError = error{
					print(isError.localizedDescription)
					return
				}

				if let localURL = localURL {
					if let string = try? String(contentsOf: localURL) {
						
						var lines: [String] = []
						string.enumerateLines { line, _ in
							lines.append(line)
						}
						for line in lines{
							fileList.append(line.components(separatedBy: "\"")[1])
						}
						UserDefaults.standard.set(self.dateNow, forKey:"date")
						UserDefaults.standard.set(fileList, forKey: fileKey)
						
					}
				}
				}.resume()
		}
		
	}
	
	func loadUpdateList() -> [String:String] {
		var tempList:[String:String] = [:]
		
		tempList[bump] = bumpPath
		
		tempList[classic] = classicPath
		tempList[future] = futurePath
		tempList[summer] = summerPath
		tempList[christmas] = christmasPath
		
		tempList[ggs] = ggsPath
		tempList[poisonJam] = poisonJamPath
		tempList[noiseTanks] = noiseTanksPath
		tempList[loveShockers] = loveShockersPath
		
		tempList[rapid99] = rapid99Path
		tempList[theImmortals] = theImmortalsPath
		tempList[doomRiders] = doomRidersPath
		tempList[goldenRhinos] = goldenRhinosPath
		
		return tempList
	}
	
	func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
		let calendar = Calendar.current
		let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
		return components.day!
	}
}
