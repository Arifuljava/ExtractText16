//
//  SecondDateManagement.swift
//  ExtractText
//
//  Created by sang on 31/8/24.
//

import Foundation

public class SecondDateManagement{
    var extracttext: String
   var xcordinated: String
   var maindata: [(key: String, value: [String])] = []
let datamanagement = DataManagement()
let timedatamanagement = TimeDataManagement()
let timecheUnderContraction = TimecheUnderContraction()
    let dateManagement = DateManagement()
init(extracttext: String, xcordinated: String) {
      self.extracttext = extracttext
      self.xcordinated = xcordinated
  }
    func processDate() -> [(key: String, value: [String])] {
        let xcordinatedArray = xcordinated.components(separatedBy: " ")
        let intArray = xcordinatedArray.compactMap { Int($0) }
        let detector = 3
        var result = DataManagement.createMapUsingSize(intArray, detector: detector)
        let sortedDictionary = datamanagement.sortDictionaryByKeys(dictionary: result)
        var datalist: [String: [String]] = [:]
        maindata.removeAll()
        for (key, value) in sortedDictionary {
            let sequence = [value]
            let extractedTimes = datamanagement.extractTimeSequence(from: extracttext, using: sequence)
            datalist[String(key)] = extractedTimes
        }
        let sortedDictionazzry = datamanagement.sortDictionaryByKeys(dictionary: datalist)
        let convertedData: [[String: [String]]] = sortedDictionazzry.map { dict in
            return [dict.key: dict.value]
        }
        maindata = dateManagement.createDateAndTimeGroup(groupsList: convertedData)
        let dictionary: [String: [String]] = Dictionary(uniqueKeysWithValues: maindata)
        maindata = datamanagement.sortDictionaryByKeys(dictionary: dictionary)
        maindata = dateManagement.mergeDateList(datelistResult: maindata)
        let datelist = dateManagement.dateConvertToList(datelistResult: maindata)
        let detectorValue = dateManagement.determineCount(datelistResult: datelist)
        let foundDatesList = dateManagement.gettingAllDatesThatIsMatches(datelistResult: maindata, detector: detectorValue)
        maindata = dateManagement.replacedDate(
            datelistResult: maindata,
            detector: detectorValue,
            sizzzee: 6,
            foundDatesList: foundDatesList
        )
        
        
        return maindata
    }
    
}
