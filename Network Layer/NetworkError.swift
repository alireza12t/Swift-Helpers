
import Alamofire
import Foundation
class NetworkError : Error  {
    var webServerErrorCode: Int
//    var carpinoError: CError
    
    init(webServerErrorCode : Int, cError: CError) {
        self.webServerErrorCode = webServerErrorCode
//        self.carpinoError = cError
    }
}
