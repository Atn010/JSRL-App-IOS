//
//  MusicHistoryVC.swift
//  JSRL IOS
//
//  Created by Antonius George S on 14/05/21.
//  Copyright © 2021 Atn010.com. All rights reserved.
//

import UIKit
import TTGSnackbar

class MusicHistoryVC: UIViewController {
	
	init() {
		super.init(nibName: nil, bundle: Bundle.init(for: MusicHistoryVC.self))
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let tableView = UITableView.init(frame: .null, style: .plain)
	let cellBGColor = UIColor.init(hexString: "#171717")
	let cellTitleColor = UIColor.init(hexString: "#DDDDDD")
	
	var historyList: [String] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		registerNotificationListener()
		updateHistoryList()
		
		self.title = "History"
		self.navigationController?.navigationBar.barStyle = .black
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		self.navigationController?.navigationBar.backgroundColor = .black
		
		self.addLeftBarButtonItem(image: UIImage.init(named: "closeButton"), selector: #selector(closeHistory))
		
		let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearHistory))
		button.tintColor = .white
		navigationItem.rightBarButtonItem = button
		
		self.view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = UIColor.init(hexString: "#111111")
		
    }
	
	@objc func closeHistory(){
		self.dismiss(animated: true, completion: nil)
	}
	
	
	@objc func clearHistory(){
		UserDefaults.standard.setValue(nil, forKey: "MusicHistory")
		self.historyList = []
		self.tableView.reloadData()
		
		let snackbar = TTGSnackbar(message: "History Cleared", duration: .middle)
		snackbar.show()
	}
	
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = self.view.frame
	}
	
	
	func updateHistoryList() {
		DispatchQueue.main.async {
			self.historyList = (UserDefaults.standard.array(forKey: "MusicHistory") as? [String] ?? []).reversed()
			self.tableView.reloadData()
		}
	}
	
	func registerNotificationListener() {
		NotificationCenter.default.addObserver(forName: .init("Update History"), object: nil, queue: .main) { [weak self] notification in
			guard let self = self else { return }
			self.updateHistoryList()
		}
	}

}


extension MusicHistoryVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return historyList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
		cell.backgroundColor = cellBGColor
		cell.textLabel?.textColor = cellTitleColor
		cell.textLabel?.text = historyList[indexPath.row]
		cell.textLabel?.numberOfLines = 0
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let track = historyList[indexPath.row]
		UIPasteboard.general.string = track
		let snackbar = TTGSnackbar(message: "\(track)\nTrack Copied", duration: .middle)
		snackbar.show()
	}
	
	
}
