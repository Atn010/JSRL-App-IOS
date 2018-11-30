//
//  ScrollText.swift
//  ScrollingText
//
//  Created by Antonius George on 08/08/18.
//  Copyright © 2018 Apple Developer Academy @ Binus. All rights reserved.
//  Based on https://stackoverflow.com/a/43022571

import UIKit

class ScrollText:UIView{
    private var labelText : String?
    private var rect0: CGRect!
    private var rect1: CGRect!
	private var rect2: CGRect!
    private var labelArray = [UILabel]()
    private var isStop = false
    private var timeInterval: TimeInterval!
    private let leadingBuffer = CGFloat(16.0)
    private let loopStartDelay = 2.0
	var currentText:String? = ""
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var BGColor: UIColor?
    private var TextColor: UIColor?
    
    
    func setup(text:String) {
		destroy()
        labelText = text
        initialize()
    }
	
	func setup(text:String, TextColor:UIColor) {
		destroy()
		labelText = text
		self.TextColor = TextColor
		initialize()
	}
    
    func setup(text:String, BackgroundColor: UIColor) {
		destroy()
        labelText = text
        BGColor = BackgroundColor
        initialize()
    }
    
    func setup(text:String, BackgroundColor: UIColor, TextColor:UIColor) {
		destroy()
        labelText = text
        BGColor = BackgroundColor
		BGColor = .clear
        self.TextColor = TextColor
        initialize()
    }
	
	
	func destroy(){
		if let viewWithTag = self.viewWithTag(100) {
			viewWithTag.removeFromSuperview()
			//labelArray.remove(at: 0)
			isStop = true
			//self.layer.removeAllAnimations()
			labelArray.removeAll()
		}
		if let viewWithTag = self.viewWithTag(101) {
			viewWithTag.removeFromSuperview()
			//labelArray.remove(at: 1)
		}
	}
    
    private func initialize() {
		destroy() // destroy previous object if available
        self.backgroundColor = BGColor ?? UIColor.clear
        let label = UILabel()
        label.text = labelText
		label.font = UIFont.preferredFont(forTextStyle: .callout)
		label.adjustsFontForContentSizeCategory = true
		currentText = labelText
        label.textColor = TextColor ?? UIColor.black
        label.frame = CGRect.zero
        
        timeInterval = TimeInterval((labelText?.count)! / 4)
        let sizeOfText = label.sizeThatFits(CGSize.zero)
        let textIsTooLong = sizeOfText.width + (leadingBuffer * 2) >= frame.size.width ? true : false
		
        rect0 = CGRect(x: leadingBuffer, y: 0, width: sizeOfText.width, height: self.bounds.size.height)
        rect1 = CGRect(x: rect0.origin.x + rect0.size.width + leadingBuffer, y: 0, width: sizeOfText.width, height: self.bounds.size.height)
		rect2 = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.bounds.size.height)

		//isStop = true
        if textIsTooLong {
			label.frame = rect0
			label.tag = 100
			super.clipsToBounds = true
			labelArray.append(label)
			self.addSubview(label)
			
            let additionalLabel = UILabel(frame: rect1)
            additionalLabel.text = label.text
            additionalLabel.textColor = label.textColor
			additionalLabel.tag = 101
			additionalLabel.font = label.font
			additionalLabel.adjustsFontForContentSizeCategory = true
            self.addSubview(additionalLabel)
            
            labelArray.append(additionalLabel)
			isStop = false
			animateLabelText(animatedText: labelText)
		}else{
			label.frame = rect2
			label.tag = 100
			label.textAlignment = .center
			super.clipsToBounds = true
			labelArray.append(label)
			self.addSubview(label)
			
		}
    }
    
    private func animateLabelText(animatedText:String?) {
        if !isStop  {
            let labelAtIndex0 = labelArray[0]
            let labelAtIndex1 = labelArray[1]
            
            UIView.animate(withDuration: timeInterval, delay: loopStartDelay, options: [.curveLinear], animations: {
                labelAtIndex0.frame = CGRect(x: -self.rect0.size.width,y: 0,width: self.rect0.size.width,height: self.rect0.size.height)
				labelAtIndex1.frame = CGRect(x: labelAtIndex0.frame.origin.x + labelAtIndex0.frame.size.width + self.leadingBuffer,y: 0,width: labelAtIndex1.frame.size.width,height: labelAtIndex1.frame.size.height)
            }, completion: { finishied in
                labelAtIndex0.frame = self.rect1
                labelAtIndex1.frame = self.rect0
				if self.isStop || animatedText != self.currentText{
					self.layer.removeAllAnimations()
				}else{
					if UIApplication.shared.applicationState != .active {
						self.isStop = true
					}
					
					self.labelArray[0] = labelAtIndex1
					self.labelArray[1] = labelAtIndex0
					self.animateLabelText(animatedText: animatedText)
				}
            })
        } else {
            self.layer.removeAllAnimations()
        }
    }
    
}

