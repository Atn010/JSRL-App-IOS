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
    private var labelArray = [UILabel]()
    private var isStop = false
    private var timeInterval: TimeInterval!
    private let leadingBuffer = CGFloat(25.0)
    private let loopStartDelay = 2.0
	var currentText:String? = ""
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var BGColor: UIColor?
    private var TextColor: UIColor?
    
    
    func setup(text:String) {
        labelText = text
        initialize()
    }
    
    func setup(text:String, BackgroundColor: UIColor) {
        labelText = text
        BGColor = BackgroundColor
        initialize()
    }
    
    func setup(text:String, TextColor:UIColor) {
        labelText = text
        self.TextColor = TextColor
        initialize()
    }
    
    func setup(text:String, BackgroundColor: UIColor, TextColor:UIColor) {
        labelText = text
        BGColor = BackgroundColor
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
        self.backgroundColor = BGColor ?? UIColor.white
        let label = UILabel()
        label.text = labelText
		currentText = labelText
        label.textColor = TextColor ?? UIColor.black
        label.frame = CGRect.zero
		label.textAlignment = .center
        
        timeInterval = TimeInterval((labelText?.count)! / 4)
        let sizeOfText = label.sizeThatFits(CGSize.zero)
        let textIsTooLong = sizeOfText.width > frame.size.width ? true : false
        
        rect0 = CGRect(x: leadingBuffer, y: 0, width: sizeOfText.width, height: self.bounds.size.height)
        rect1 = CGRect(x: rect0.origin.x + rect0.size.width, y: 0, width: sizeOfText.width, height: self.bounds.size.height)
        label.frame = rect0
        label.tag = 100
        super.clipsToBounds = true
        labelArray.append(label)
        self.addSubview(label)
		//isStop = true
        if textIsTooLong {
            let additionalLabel = UILabel(frame: rect1)
            additionalLabel.text = labelText
            additionalLabel.textColor = TextColor
			additionalLabel.tag = 101
            self.addSubview(additionalLabel)
            
            labelArray.append(additionalLabel)
			isStop = false
			animateLabelText(animatedText: labelText)
        }
    }
    
    private func animateLabelText(animatedText:String?) {
        if !isStop  {
            let labelAtIndex0 = labelArray[0]
            let labelAtIndex1 = labelArray[1]
            
            UIView.animate(withDuration: timeInterval, delay: loopStartDelay, options: [.curveLinear], animations: {
                labelAtIndex0.frame = CGRect(x: -self.rect0.size.width,y: 0,width: self.rect0.size.width,height: self.rect0.size.height)
                labelAtIndex1.frame = CGRect(x: labelAtIndex0.frame.origin.x + labelAtIndex0.frame.size.width + 25,y: 0,width: labelAtIndex1.frame.size.width,height: labelAtIndex1.frame.size.height)
            }, completion: { finishied in
                labelAtIndex0.frame = self.rect1
                labelAtIndex1.frame = self.rect0
				if self.isStop || animatedText != self.currentText{
					self.layer.removeAllAnimations()
				}else{
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

