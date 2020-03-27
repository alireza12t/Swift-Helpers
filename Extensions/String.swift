import UIKit

extension String {
    
    /// Encode String to Base 64
    func fromBase64() -> String? {
        CLog.i()
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    
    /// Decode String from Base 64
    func toBase64() -> String {
        CLog.i()
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Convert English number string to persian
    func convertNumberToPersian()-> String {
        CLog.i()
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }

    /// Convert English number string to persian
    func convertNumberToEnglish()-> String {
        CLog.i()
        let numbersDictionary : Dictionary = ["۰": "0", "۱": "1", "۲": "2", "۳": "3", "۴": "4", "۵": "5", "۶": "6", "۷": "7", "۸": "8", "۹": "9"]
        var str : String = self

        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }

        return str
    }
    
    
    /// String Characters count
    var length: Int {
      return count
    }

    subscript (i: Int) -> String {
      return self[i ..< i + 1]
    }

    
    /// Return subString from index i to last
    func substring(fromIndex: Int) -> String {
        CLog.i()
      return self[min(fromIndex, length) ..< length]
    }

    /// Return subString from first to  index i
    func substring(toIndex: Int) -> String {
        CLog.i()
      return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
      let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                          upper: min(length, max(0, r.upperBound))))
      let start = index(startIndex, offsetBy: range.lowerBound)
      let end = index(start, offsetBy: range.upperBound - range.lowerBound)
      return String(self[start ..< end])
    }
}
