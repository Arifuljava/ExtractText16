//
//  ViewController.swift
//  ExtractText
//
//  Created by sang on 26/8/24.
//

import UIKit
import Vision

class ViewController: UIViewController, TextClassificationelegate {
    func canextractdata(extracttext: String,xcordinated : String) {
       /*
        let timedataextractor = FirstTimeManagement(extracttext: extracttext, xcordinated: xcordinated)
        let finaltimelist = timedataextractor.processTime()
        print(finaltimelist)
        */
    
        let timedataextractor = SecondDateManagement(extracttext: extracttext, xcordinated: xcordinated)
        let finaltimelist = timedataextractor.processDate()
        print(finaltimelist)
    }
    
    func cannotgetdata() {
        print("VVVVV")
    }
    var datalist: [String: [String]] = [:]
    let textClassifier = TextClassification()
    let datamanagement = DataManagement()
    let timedatamanagement = TimeDataManagement()
    let timecheUnderContraction = TimecheUnderContraction()
    var maindata: [(key: String, value: [String])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        textClassifier.delegate = self
        
    }
    func createBitmapImage(width: Int, height: Int, backgroundColor: UIColor = .white, overlayImage: UIImage? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        context.setFillColor(backgroundColor.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        if let overlayImage = overlayImage {
            let overlaySize = overlayImage.size
            let overlayRect = CGRect(
                x: (CGFloat(width) - overlaySize.width) / 2,
                y: (CGFloat(height) - overlaySize.height) / 2,
                width: overlaySize.width,
                height: overlaySize.height
            )
            overlayImage.draw(in: overlayRect)
        }
        let bitmapImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return bitmapImage
    }
    @IBAction func extracttext(_ sender: UIButton) {
        
       
        
        if let image = UIImage(named: "realimage_reed"),//Wgggg//realimage_reed
           let cgImage = image.cgImage {
            print(cgImage.height.description)
            print(cgImage.width.description)
            self.textClassifier.recognizeText(from: cgImage);
        } else {
            print("Image not found")
        }

    }
    func groupTimesByDate(from inputString: String) -> [String: [String]] {
        let timeStrings = inputString.components(separatedBy: " ")
        var groupedTimes = [String: [String]]()
        for time in timeStrings {
            let date = String(time.prefix(2))
            if groupedTimes[date] != nil {
                if time.isEmpty || time == ""
                {
                    
                }
                else{
                    groupedTimes[date]?.append(time)
                }
                
            } else {
                if time.isEmpty || time == ""
                {
                    
                }
                else{
                    groupedTimes[date] = [time]
                }
                
            }
        }

        return groupedTimes
    }
}

