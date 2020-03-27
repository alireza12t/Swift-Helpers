//
//  ShamsiDateFormatter.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 12/16/19.
//  Copyright © 2019 carpino corp. All rights reserved.
//

import UIKit




/// This Class for Converting TimeStamp to CustomDate
class CustomDateFormatter {

    /**
     This function is for converting TimeStamp to CustomDate(Miladi)
     - parameters:
        - timeValue: Int
     */
    static func convertTimestampToMiladi(timeValue: Int) -> CustomDate{
        let date = Date(timeIntervalSince1970: TimeInterval(timeValue/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MM yyyy HH mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+03:30")
        let formattedDate = dateFormatter.string(from: date).split(separator: " ")
        var response = CustomDate()
        response.dayName = String(formattedDate[0])
        response.day = Int(String(formattedDate[1]))!
        response.month = Int(String(formattedDate[2]))!
        response.year = Int(String(formattedDate[3]))!
        response.hour = Int(String(formattedDate[4]))!
        response.minute = Int(String(formattedDate[5]))!

        return response
    }
    
    /**
     This function is for converting TimeStamp to CustomDate(Shamsi)
     - parameters:
        - timeValue: Int
     */
    static func convertTimestampToShamsi(timeValue: Int) -> CustomDate{
        let miladi = CustomDateFormatter.convertTimestampToMiladi(timeValue: timeValue)
        var response = CustomDate()
        
        switch miladi.dayName {
        case "Saturday":
            response.dayName = StringHelper.getDayName(day: 0)
        case "Sunday":
            response.dayName = StringHelper.getDayName(day: 1)
        case "Monday":
            response.dayName = StringHelper.getDayName(day: 2)
        case "Tuesday":
            response.dayName = StringHelper.getDayName(day: 3)
        case "Wednesday":
            response.dayName = StringHelper.getDayName(day: 4)
        case "Thursday":
            response.dayName = StringHelper.getDayName(day: 5)
        case "Friday":
            response.dayName = StringHelper.getDayName(day: 6)
        default:
            response.dayName = StringHelper.getDayName(day: -1)
        }
        
        let shamsi = toJalaali(gy: miladi.year, miladi.month, miladi.day)
        
        response.day = shamsi.day
        response.month = shamsi.month
        response.year = shamsi.year
        
        response.hour = miladi.hour
        response.minute = miladi.minute

        return response
    }
    
}


