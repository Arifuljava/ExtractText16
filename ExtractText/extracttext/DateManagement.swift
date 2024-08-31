//
//  DateManagement.swift
//  ExtractText
//
//  Created by sang on 31/8/24.
//

import Foundation

public class DateManagement{
    func createDateAndTimeGroup(groupsList: [[String: [String]]]) -> [(key: String, value: [String])] {
        var maindata: [(key: String, value: [String])] = []
        
        if !groupsList.isEmpty {
            for i in 0..<groupsList.count {
                let dict = groupsList[i]
                for (key, value) in dict {
                    let result = createFromEachTarget(targetList: value)
                    let dateListFinal = result.dateList
                    maindata.append((key: "\(i)", value: dateListFinal))
                }
            }
        }
       

        return maindata
    }
    func createFromEachTarget(targetList: [String]) -> (dateList: [String], timeList: [String]) {
        var dateList: [String] = []
        var timeList: [String] = []

        for targetword in targetList {
            let result = checkingcolumn(targetword: targetword)
            
            let dateListTarget = result.dateList
            let timeListTarget = result.timeList
            
            dateList.append(contentsOf: dateListTarget)
            timeList.append(contentsOf: timeListTarget)
        }

        return (dateList, timeList)
    }
    func checkingcolumn(targetword: String) -> (dateList: [String], timeList: [String]) {
        var dateList: [String] = []
        var timeList: [String] = []

        if targetword.count >= 6 {
            if targetword.contains(":") {
                let colons = countColons(in: targetword)
                if colons > 1 {
                    let timeParts = extractTimeParts(from: targetword)
                    let dateword = String(targetword.prefix(2))
                    for var timePart in timeParts {
                        timePart = replacedData(in: timePart)
                        timeList.append(timePart)
                        dateList.append(dateword)
                    }
                } else {
                    let colonIndex = targetword.firstIndex(of: ":")!
                    let prefixStart = targetword.index(colonIndex, offsetBy: -2, limitedBy: targetword.startIndex) ?? targetword.startIndex
                    let suffixEnd = targetword.index(colonIndex, offsetBy: 3, limitedBy: targetword.endIndex) ?? targetword.endIndex
                    let prefix = String(targetword[prefixStart..<colonIndex])
                    let suffix = String(targetword[colonIndex..<suffixEnd])
                    var timeword = prefix + suffix

                    let totalLength = targetword.count
                    let timeLength = timeword.count
                    let gettings = totalLength - timeLength
                    let dateword = String(targetword.prefix(gettings))
                    
                    timeword = replacedData(in: timeword)
                    timeList.append(timeword)
                    dateList.append(dateword)
                }
            } else {
                let dateword = String(targetword.prefix(2))
                var timeword = String(targetword.suffix(from: targetword.index(targetword.startIndex, offsetBy: 2)))
                timeword = replacedData(in: timeword)
                timeList.append(timeword)
                dateList.append(dateword)
            }
        } else {
            if targetword.count >= 2 {
                let dateword = String(targetword.prefix(2))
                var timeword = String(targetword.suffix(from: targetword.index(targetword.startIndex, offsetBy: 2)))
                timeword = replacedData(in: timeword)
                timeList.append(timeword)
                dateList.append(dateword)
            }
        }

        return (dateList, timeList)
    }
    private func countColons(in text: String?) -> Int {
        guard let text = text, !text.isEmpty else {
            return 0
        }

        var count = 0
        for char in text {
            if char == ":" {
                count += 1
            }
        }
        return count
    }

    func replacedData(in input: String) -> String {
        return input
            .replacingOccurrences(of: "X", with: ":")
            .replacingOccurrences(of: "x", with: ":")
            .replacingOccurrences(of: "J", with: "1")
            .replacingOccurrences(of: "j", with: "1")
            .replacingOccurrences(of: "L", with: "1")
            .replacingOccurrences(of: "l", with: "1")
            .replacingOccurrences(of: "s", with: "5")
            .replacingOccurrences(of: "S", with: "5")
            .replacingOccurrences(of: "a", with: "8")
            .replacingOccurrences(of: "A", with: "8")
            .replacingOccurrences(of: "o", with: "0")
            .replacingOccurrences(of: "O", with: "0")
            .replacingOccurrences(of: "B", with: "8")
            .replacingOccurrences(of: "b", with: "2")
            .replacingOccurrences(of: "Þ", with: "2")
            .replacingOccurrences(of: "P", with: "9")
            .replacingOccurrences(of: "D", with: "0")
            .replacingOccurrences(of: "$", with: "3")
            .replacingOccurrences(of: ".", with: ":")
            .replacingOccurrences(of: "H", with: "4")
            .replacingOccurrences(of: "\"", with: ":")
            .replacingOccurrences(of: "*\"", with: " ")
            .replacingOccurrences(of: "\'", with: ":")
            .replacingOccurrences(of: "(", with: " ")
            .replacingOccurrences(of: ")", with: " ")
            .replacingOccurrences(of: "I", with: "1")
            .replacingOccurrences(of: "T", with: "1")
            .replacingOccurrences(of: "Z", with: "2")
            .replacingOccurrences(of: "z", with: "2")
            .replacingOccurrences(of: "|", with: " ")
            .replacingOccurrences(of: "į", with: "1")
            .replacingOccurrences(of: "þ", with: "1")
            .replacingOccurrences(of: "?", with: "2")
            .replacingOccurrences(of: "%", with: "3")
            .replacingOccurrences(of: "p", with: "2")
            .replacingOccurrences(of: "h", with: "1")
            .replacingOccurrences(of: "İ", with: "1")
            .replacingOccurrences(of: "i", with: "1")
            .replacingOccurrences(of: "*", with: ":")
            .replacingOccurrences(of: "\\", with: " ")
            .replacingOccurrences(of: "/", with: " ")
            .replacingOccurrences(of: "g", with: "0")
            .replacingOccurrences(of: "U", with: " ")
            .replacingOccurrences(of: "::", with: ":0")
            .replacingOccurrences(of: "-", with: ":")
            .replacingOccurrences(of: "N", with: ":")
            .replacingOccurrences(of: "[", with: ":")
            .replacingOccurrences(of: "\\/:", with: ":")
            .replacingOccurrences(of: "|/", with: " ")
            .replacingOccurrences(of: "T\"\\", with: ":")
            .replacingOccurrences(of: "|(", with: " ")
            .replacingOccurrences(of: " \"", with: ":")
            .replacingOccurrences(of: "#", with: "0")
            .replacingOccurrences(of: "]", with: "1")
    }
    func extractTimeParts(from input: String) -> [String] {
        var result = [String]()
        let regex = try! NSRegularExpression(pattern: "(\\d{1,2}):(\\d{1,2})", options: [])
        let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        
        for match in matches {
            if let leftRange = Range(match.range(at: 1), in: input),
               let rightRange = Range(match.range(at: 2), in: input) {
                var leftPart = String(input[leftRange])
                var rightPart = String(input[rightRange])
                
                if leftPart.count == 1 {
                    leftPart = "0" + leftPart
                }
                if rightPart.count == 1 {
                    rightPart = "0" + rightPart
                }
                
                result.append("\(leftPart):\(rightPart)")
            }
        }
        
        return result
    }
    func mergeDateList(datelistResult: [(key: String, value: [String])]) -> [(key: String, value: [String])] {
        var datelistrroup: [(key: String, value: [String])] = []
        var datechecking: [String] = []
        var aaaa = 0

        for i in 0..<datelistResult.count {
            let key = String(i)
            let dates = datelistResult.first { $0.key == key }?.value ?? []

            if dates.count >= 6 {
                if datechecking.count < 6 {
                    if datechecking.isEmpty {
                        // Do nothing, just skip to next iteration
                    } else {
                        datelistrroup.append((key: "\(aaaa)", value: datechecking))
                        aaaa += 1
                        datechecking.removeAll()
                    }
                    datelistrroup.append((key: "\(aaaa)", value: dates))
                    aaaa += 1
                }
            } else {
                datechecking = checkingTwoElements(list1: datechecking, list2: dates)

                if datechecking.count >= 6 {
                    datelistrroup.append((key: "\(aaaa)", value: datechecking))
                    aaaa += 1
                    datechecking.removeAll()
                } else if i < datelistResult.count - 1 {
                    if datechecking.count < 6 {
                        datelistrroup.append((key: "\(aaaa)", value: datechecking))
                        aaaa += 1
                        datechecking.removeAll()
                    }
                }
            }
        }
        return datelistrroup
    }

  
    func checkingTwoElements(list1: [String], list2: [String]) -> [String] {
        var datechecking: [String] = []
        
        if list1.isEmpty {
            datechecking = list2
        } else {
            datechecking = containsAllElements(list1: list1, list2: list2)
        }
        
        return datechecking
    }
    func containsAllElements(list1: [String], list2: [String]) -> [String] {
        var datechecking = list1
        
        for word in list2 {
            datechecking.append(word)
        }
        
        return datechecking
    }
    func dateConvertToList(datelistResult: [(key: String, value: [String])]) -> [String] {
        var flattenedList: [String] = []
        
        for (_, list) in datelistResult {
            flattenedList.append(contentsOf: list)
        }
        
        return flattenedList
    }
    func determineCount(datelistResult: [String]) -> Int {
        var countZeroTo15 = 0
        var count15To31 = 0
        var detector = 0
        
        for date in datelistResult {
            var kk = date
            if kk.count > 2 {
                kk = String(kk.prefix(2))
            }
            if !kk.isEmpty {
                if let value = Int(kk) {
                    if value > 15 {
                        count15To31 += 1
                    } else {
                        countZeroTo15 += 1
                    }
                }
            }
        }
        
        if countZeroTo15 > count15To31 {
            detector = 1
        } else {
            detector = 16
        }
        
        return detector
    }
    func gettingAllDatesThatIsMatches(datelistResult: [(key: String, value: [String])], detector: Int) -> [String] {
      var datelistrroup = [(key: String, value: [String])]()
      var kk = detector
      var dateChecking = [String]()
      var mainKey = 0
      print(datelistResult)
      for i in 0...15 {
          let key = String(mainKey)
          if let entry = datelistResult.first(where: { $0.key == key }) {
              let dates = entry.value
              print("mainKey \(kk)   dates  \(dates)")
              
              var element = ""
              if kk < 10 {
                  element = "0\(kk)"
              } else {
                  element = "\(kk)"
              }
              if dates.contains(element) {
                  dateChecking = replacedWithCount1(dates: dates, detector: kk, sizeeee: 1)
                  datelistrroup.append((key: "\(i)", value: dateChecking))
                  mainKey += 1
              }
          }
          kk += 1
      }
      var foundDatesList = dateConvertToList(datelistResult: datelistrroup)
      foundDatesList.sort()
      return foundDatesList
      
    }
    func replacedWithCount1(dates: [String], detector: Int, sizeeee: Int) -> [String] {
        var dateChecking = [String]()
        var size = 1
        
        var element: String
        if detector > 9 {
            element = "\(detector)"
        } else {
            element = "0\(detector)"
        }
        
        for _ in 0..<size {
            dateChecking.append(element)
        }
    
        return dateChecking
    }
    func replacedDate(
        datelistResult: [(key: String, value: [String])],
        detector: Int,
        sizzzee: Int,
        foundDatesList: [String]
    ) -> [(key: String, value: [String])] {
        
        var datelistrroup: [(key: String, value: [String])] = []
        let kk = detector
        var mainkey = 0
       
        for (index, key) in foundDatesList.enumerated() {
            let datechecking = replacedwithcount(dates: [key], detector: Int(key) ?? 0, sizeeee: sizzzee)
            datelistrroup.append((key: "\(index)", value: datechecking))
            mainkey += 1
        }
        let dictionary: [String: [String]] = Dictionary(uniqueKeysWithValues: datelistrroup)
        let datamanagement = DataManagement()
        datelistrroup = datamanagement.sortDictionaryByKeys(dictionary: dictionary)
        return datelistrroup
    }
    func replacedwithcount(dates: [String], detector: Int, sizeeee: Int) -> [String] {
        var datechecking: [String] = []

        var size = 6
        if size > 6 {
            size = 6
        }

        let element: String
        if detector > 9 {
            element = "\(detector)"
        } else {
            element = String(format: "0%d", detector)
        }

        for _ in 0..<size {
            datechecking.append(element)
        }

        return datechecking
    }

}
