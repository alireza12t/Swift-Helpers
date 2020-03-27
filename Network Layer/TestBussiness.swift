

import Foundation
import Alamofire

let BASEURL = Bundle.main.infoDictionary?["ServerName"] as! String



enum TestBussiness: APIConfiguration {
    

    // case [caseName]( [InputName] : Type, ....)

    var METHOD: HTTPMethod {
        switch self {
//        case .[CaseName]:
//            return .post
//        case .[CaseName]:
//            return .put
//        case .[CaseName]:
//            return .delete
//        default:
//            return .get
        }
    }
    
    var FULL_PATH_URL: String
    {
        switch self {
//        case .[CaseName]:
//            return BASEURL + "API URL"
        }
    }
    
    var PARAMETERS: Parameters?
    {
        switch self {
//        case .[CaseName](let [Input Name], .....):
//            return [
//                NetworkConstant.APIParameterKey.[StructName].[VariableName]: "Variable Content"
//            ]


        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: try FULL_PATH_URL.asURL())
        var urlComponents = URLComponents(string: "\(urlRequest)")
        
        if let parameters = PARAMETERS {
            var param = [URLQueryItem]()
            parameters.keys.forEach({ (key) in param.append(URLQueryItem(name: key, value: "\(parameters[key]!)")) })
            urlComponents?.queryItems = param.reversed()
            
        }

        urlRequest = URLRequest(url: (urlComponents?.url)!)

        //Add HTTP Body to API
        switch self {
    
//        case case .[CaseName](let [Input Name], .....):
//            let json: [String: Any] = [
//                "rates":
//                    [
//                        [
//                            "rate": driverRate,
//                            "slug": ""
//
//                        ],
//                        [
//                            "rate": carRate,
//                            "slug": ""
//                        ]
//                ]
//            ]
//            CLog.i("HTTP Body =>  \(json)")
//
//            do {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: json)
//            } catch let error {
//                CLog.e(error.localizedDescription)
//            }
            

        default:
            break
        }

        urlRequest.httpMethod = METHOD.rawValue
        urlRequest.timeoutInterval = 8
        urlRequest.setValue(NetworkConstant.ContentType.json, forHTTPHeaderField: NetworkConstant.HTTPHeaderField.acceptType)
        urlRequest.setValue(NetworkConstant.ContentType.json, forHTTPHeaderField:
            NetworkConstant.HTTPHeaderField.contentType)
        
        switch self {

//        case .[CaseName](let [Input Name], .....):
//            urlRequest.setValue("", forHTTPHeaderField: NetworkConstant.HTTPHeaderField.authentication)
//        case .[CaseName]:
//            break
//        default:
//            urlRequest.setValue("[APIToken]", forHTTPHeaderField: NetworkConstant.HTTPHeaderField.authentication)
        }

        CLog.i("\(urlRequest)")
        CLog.i("\(urlRequest.allHTTPHeaderFields!)")
        return urlRequest
        
    }
}
