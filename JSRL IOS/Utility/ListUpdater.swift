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
		
		for (key, value) in updateList{
			downloadList(fileUrl: "\(StationListInfo.jetsetradio.rawValue)\(StationListInfo.stationPath.rawValue)\(value)\(StationListInfo.listPath.rawValue)", fileKey: key)
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
							if line.contains("\"") {
								lines.append(line)
							}
						}
						for line in lines{
							fileList.append(line.components(separatedBy: "\"")[1])
							print( "\(fileKey) ~ \(line.components(separatedBy: "\"")[1])")
						}
						UserDefaults.standard.set(self.dateNow, forKey:"date")
						UserDefaults.standard.set(fileList, forKey: fileKey)
						//print(fileList)
						
					}
				}
				}.resume()
		}
		
	}
	
	private func loadUpdateList() -> [String: String] {
		var tempList: [String: String] = [:]
		
		tempList[StationListInfo.Name.bump.rawValue] = StationListInfo.Path.bump.rawValue
		
		tempList[StationListInfo.Name.classic.rawValue] = StationListInfo.Path.classic.rawValue
		tempList[StationListInfo.Name.future.rawValue] = StationListInfo.Path.future.rawValue
		tempList[StationListInfo.Name.summer.rawValue] = StationListInfo.Path.summer.rawValue
		tempList[StationListInfo.Name.christmas.rawValue] = StationListInfo.Path.christmas.rawValue
		
		tempList[StationListInfo.Name.ggs.rawValue] = StationListInfo.Path.ggs.rawValue
		tempList[StationListInfo.Name.poisonJam.rawValue] = StationListInfo.Path.poisonJam.rawValue
		tempList[StationListInfo.Name.noiseTanks.rawValue] = StationListInfo.Path.noiseTanks.rawValue
		tempList[StationListInfo.Name.loveShockers.rawValue] = StationListInfo.Path.loveShockers.rawValue
		
		tempList[StationListInfo.Name.rapid99.rawValue] = StationListInfo.Path.rapid99.rawValue
		tempList[StationListInfo.Name.theImmortals.rawValue] = StationListInfo.Path.theImmortals.rawValue
		tempList[StationListInfo.Name.doomRiders.rawValue] = StationListInfo.Path.doomRiders.rawValue
		tempList[StationListInfo.Name.goldenRhinos.rawValue] = StationListInfo.Path.goldenRhinos.rawValue
		
		return tempList
	}
	
	private func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
		let calendar = Calendar.current
		let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
		return components.day!
	}
}
