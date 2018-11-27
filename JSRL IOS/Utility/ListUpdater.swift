//
//  ListUpdater.swift
//  JSRL IOS
//
//  Created by Antonius George on 02/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class ListUpdater: NSObject {
	
	private let dateNow = Date()
	private let stationInfo = StationListInfo()
	

	private var updateList:[String:String] = [:]
	
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
	
	private func getAndUpdateList() {
		updateList = loadUpdateList()
		
		for (key,value) in updateList{
			downloadList(fileUrl: "\(stationInfo.jetsetradio)\(stationInfo.stationPath)\(value)\(stationInfo.listPath)", fileKey: key)
		}
		
		
	}
	
	private func downloadList(fileUrl:String, fileKey:String){
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
						print(fileList)
						
					}
				}
				}.resume()
		}
		
	}
	
	private func loadUpdateList() -> [String:String] {
		var tempList:[String:String] = [:]
		
		tempList[stationInfo.bump] = stationInfo.bumpPath
		
		tempList[stationInfo.classic] = stationInfo.classicPath
		tempList[stationInfo.future] = stationInfo.futurePath
		tempList[stationInfo.summer] = stationInfo.summerPath
		tempList[stationInfo.christmas] = stationInfo.christmasPath
		
		tempList[stationInfo.ggs] = stationInfo.ggsPath
		tempList[stationInfo.poisonJam] = stationInfo.poisonJamPath
		tempList[stationInfo.noiseTanks] = stationInfo.noiseTanksPath
		tempList[stationInfo.loveShockers] = stationInfo.loveShockersPath
		
		tempList[stationInfo.rapid99] = stationInfo.rapid99Path
		tempList[stationInfo.theImmortals] = stationInfo.theImmortalsPath
		tempList[stationInfo.doomRiders] = stationInfo.doomRidersPath
		tempList[stationInfo.goldenRhinos] = stationInfo.goldenRhinosPath
		
		return tempList
	}
	
	private func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
		let calendar = Calendar.current
		let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
		return components.day!
	}
}
