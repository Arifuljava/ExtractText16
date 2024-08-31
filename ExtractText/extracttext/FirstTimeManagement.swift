//
//  FirstTimeManagement.swift
//  ExtractText
//
//  Created by sang on 31/8/24.
//

import Foundation
public class FirstTimeManagement{
          var extracttext: String
         var xcordinated: String
         var maindata: [(key: String, value: [String])] = []
    let datamanagement = DataManagement()
    let timedatamanagement = TimeDataManagement()
    let timecheUnderContraction = TimecheUnderContraction()
    init(extracttext: String, xcordinated: String) {
            self.extracttext = extracttext
            self.xcordinated = xcordinated
        }
        
        func processTime() -> [(key: String, value: [String])] {
            print(extracttext)
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
            let convertedData: [[String: [String]]] = maindata.map { dict in
                return [dict.key: dict.value]
            }
            var (dateGroup, timeGroup) = timedatamanagement.createDateAndTimeGroup(groupsList: convertedData)
            timeGroup = timedatamanagement.removeNullDataFromTimeList(groupsList: [timeGroup])
            maindata.removeAll()
            maindata =  timedatamanagement.sortByKey(map: timeGroup)
            maindata =  timecheUnderContraction.checkingAlignment(timelistResult: maindata)
            let userDataGiven = ["08:00", "12:00", "13:00","17:00", "18:00", "20:00"]
            let timerangelist = timedatamanagement.createRange(userdataGiven: userDataGiven)
            maindata =  timecheUnderContraction.checkingTimeRange(timelistResult: maindata, rangelist: timerangelist)
            return maindata
        }
}





/*
 func canextractdata(extracttext: String,xcordinated : String) {
         print(extracttext)
         let xcordinatedArray = xcordinated.components(separatedBy: " ")
         let intArray = xcordinatedArray.compactMap { Int($0) }
         let detector = 3
         var result = DataManagement.createMapUsingSize(intArray, detector: detector)
         let sortedDictionary = datamanagement.sortDictionaryByKeys(dictionary: result)
         datalist.removeAll()
         maindata.removeAll()
         for (key, value) in sortedDictionary {
             let sequence = [value]
             let extractedTimes = datamanagement.extractTimeSequence(from: extracttext, using: sequence)
             datalist[String(key)] = extractedTimes
         }
         maindata = datamanagement.sortDictionaryByKeys(dictionary: datalist)
         let convertedData: [[String: [String]]] = maindata.map { dict in
             return [dict.key: dict.value]
         }
         var (dateGroup, timeGroup) = timedatamanagement.createDateAndTimeGroup(groupsList: convertedData)
         timeGroup = timedatamanagement.removeNullDataFromTimeList(groupsList: [timeGroup])
         maindata.removeAll()
         maindata =  timedatamanagement.sortByKey(map: timeGroup)
         maindata =  timecheUnderContraction.checkingAlignment(timelistResult: maindata)
         let userDataGiven = ["08:00", "12:00", "13:00","17:00", "18:00", "20:00"]
         let timerangelist = timedatamanagement.createRange(userdataGiven: userDataGiven)
         maindata =  timecheUnderContraction.checkingTimeRange(timelistResult: maindata, rangelist: timerangelist)
         print(maindata)
     }
     
 */
