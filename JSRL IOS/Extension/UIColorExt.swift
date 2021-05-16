//
//  UIColorExt.swift
//  JSRL IOS
//
//  Created by Antonius George on 30/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import ImageIO

extension Array {
	public subscript(safe index: Int) -> Element? {
		guard index >= 0, index < endIndex else {
			return nil
		}

		return self[index]
	}
}

extension Optional where Wrapped == String {
	var isBlank: Bool {
		return self?.isBlank ?? true
	}
}


extension String {
	var isBlank: Bool {
		return allSatisfy({ $0.isWhitespace })
	}
}


extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}
	
	convenience init(hexString: String) {
		let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int = UInt32()
		Scanner(string: hex).scanHexInt32(&int)
		let a, r, g, b: UInt32
		switch hex.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (255, 0, 0, 0)
		}
		self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
	}
	
	func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
		return self.adjust(by: abs(percentage) )
	}
	
	func darker(by percentage: CGFloat = 30.0) -> UIColor? {
		return self.adjust(by: -1 * abs(percentage) )
	}
	
	func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
		var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return UIColor(red: min(red + percentage/100, 1.0),
						   green: min(green + percentage/100, 1.0),
						   blue: min(blue + percentage/100, 1.0),
						   alpha: alpha)
		} else {
			return nil
		}
	}
}


extension UIButton{
	override open func awakeFromNib() {
		super.awakeFromNib()
		tintColorDidChange()
	}
}

extension UIImageView {
	
	override open func awakeFromNib() {
			super.awakeFromNib()
			tintColorDidChange()
		}
	
	
	public func loadGif(name: String) {
		DispatchQueue.global().async {
			let image = UIImage.gif(name: name)
			DispatchQueue.main.async {
				self.image = image
			}
		}
	}
	
}

extension UIImage {
	
	
	public class func gif(data: Data) -> UIImage? {
		// Create source from data
		guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
			print("SwiftGif: Source for the image does not exist")
			return nil
		}
		
		return UIImage.animatedImageWithSource(source)
	}
	
	public class func gif(url: String) -> UIImage? {
		// Validate URL
		guard let bundleURL = URL(string: url) else {
			print("SwiftGif: This image named \"\(url)\" does not exist")
			return nil
		}
		
		// Validate data
		guard let imageData = try? Data(contentsOf: bundleURL) else {
			print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
			return nil
		}
		
		return gif(data: imageData)
	}
	
	public class func gif(name: String) -> UIImage? {
		// Check for existance of gif
		guard let bundleURL = Bundle.main
			.url(forResource: name, withExtension: "gif") else {
				print("SwiftGif: This image named \"\(name)\" does not exist")
				return nil
		}
		
		// Validate data
		guard let imageData = try? Data(contentsOf: bundleURL) else {
			print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
			return nil
		}
		
		return gif(data: imageData)
	}
	
	internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
		var delay = 0.1
		
		// Get dictionaries
		let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
		let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
		if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
			return delay
		}
		
		let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
		
		// Get delay time
		var delayObject: AnyObject = unsafeBitCast(
			CFDictionaryGetValue(gifProperties,
								 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
			to: AnyObject.self)
		if delayObject.doubleValue == 0 {
			delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
															 Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
		}
		
		delay = delayObject as? Double ?? 0
		
		if delay < 0.1 {
			delay = 0.1 // Make sure they're not too fast
		}
		
		return delay
	}
	
	internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
		var a = a
		var b = b
		// Check if one of them is nil
		if b == nil || a == nil {
			if b != nil {
				return b!
			} else if a != nil {
				return a!
			} else {
				return 0
			}
		}
		
		// Swap for modulo
		if a! < b! {
			let c = a
			a = b
			b = c
		}
		
		// Get greatest common divisor
		var rest: Int
		while true {
			rest = a! % b!
			
			if rest == 0 {
				return b! // Found it
			} else {
				a = b
				b = rest
			}
		}
	}
	
	internal class func gcdForArray(_ array: Array<Int>) -> Int {
		if array.isEmpty {
			return 1
		}
		
		var gcd = array[0]
		
		for val in array {
			gcd = UIImage.gcdForPair(val, gcd)
		}
		
		return gcd
	}
	
	internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
		let count = CGImageSourceGetCount(source)
		var images = [CGImage]()
		var delays = [Int]()
		
		// Fill arrays
		for i in 0..<count {
			// Add image
			if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
				images.append(image)
			}
			
			// At it's delay in cs
			let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
															source: source)
			delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
		}
		
		// Calculate full duration
		let duration: Int = {
			var sum = 0
			
			for val: Int in delays {
				sum += val
			}
			
			return sum
		}()
		
		// Get frames
		let gcd = gcdForArray(delays)
		var frames = [UIImage]()
		
		var frame: UIImage
		var frameCount: Int
		for i in 0..<count {
			frame = UIImage(cgImage: images[Int(i)])
			frameCount = Int(delays[Int(i)] / gcd)
			
			for _ in 0..<frameCount {
				frames.append(frame)
			}
		}
		
		// Heyhey
		let animation = UIImage.animatedImage(with: frames,
											  duration: Double(duration) / 1000.0)
		
		return animation
	}
	
	// colorize image with given tint color
	// this is similar to Photoshop's "Color" layer blend mode
	// this is perfect for non-greyscale source images, and images that have both highlights and shadows that should be preserved
	// white will stay white and black will stay black as the lightness of the image is preserved
	func tint(tintColor: UIColor) -> UIImage {
		
		return modifiedImage { context, rect in
			// draw black background - workaround to preserve color of partially transparent pixels
			context.setBlendMode(.normal)
			UIColor.black.setFill()
			context.fill(rect)
			
			// draw original image
			context.setBlendMode(.normal)
			context.draw(self.cgImage!, in: rect)
			
			// tint image (loosing alpha) - the luminosity of the original image is preserved
			context.setBlendMode(.color)
			tintColor.setFill()
			context.fill(rect)
			
			// mask by alpha values of original image
			context.setBlendMode(.destinationIn)
			context.draw(self.cgImage!, in: rect)
		}
	}
	
	// fills the alpha channel of the source image with the given color
	// any color information except to the alpha channel will be ignored
	func fillAlpha(fillColor: UIColor) -> UIImage {
		
		return modifiedImage { context, rect in
			// draw tint color
			context.setBlendMode(.normal)
			fillColor.setFill()
			context.fill(rect)
			//            context.fillCGContextFillRect(context, rect)
			
			// mask by alpha values of original image
			context.setBlendMode(.destinationIn)
			context.draw(self.cgImage!, in: rect)
		}
	}
	
	func maskWithColor(color: UIColor) -> UIImage? {
		let maskImage = cgImage!
		
		let width = size.width
		let height = size.height
		let bounds = CGRect(x: 0, y: 0, width: width, height: height)
		
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
		let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
		
		context.clip(to: bounds, mask: maskImage)
		context.setFillColor(color.cgColor)
		context.fill(bounds)
		
		if let cgImage = context.makeImage() {
			let coloredImage = UIImage(cgImage: cgImage)
			return coloredImage
		} else {
			return nil
		}
	}
	
	private func modifiedImage( draw: (CGContext, CGRect) -> ()) -> UIImage {
		
		// using scale correctly preserves retina images
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		let context: CGContext! = UIGraphicsGetCurrentContext()
		assert(context != nil)
		
		// correctly rotate image
		context.translateBy(x: 0, y: size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		
		let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
		
		draw(context, rect)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}
	
}
