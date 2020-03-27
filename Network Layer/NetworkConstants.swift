
import Foundation


struct NetworkConstant {
    
    struct ServerURL
    {
        static let Production = ""
        static let QA = ""
        static let Local = ""
    }
    
    struct APIParameterKey {
        
//        struct [CaseName]{
//            static let [VariableName] = "[VariableName]"
//        }
        
       
        
    }
    
    
    struct HTTPHeaderField {
        static let authentication = "Authorization"
        static let contentType = "Content-Type"
        static let acceptType = "Accept"
        static let acceptEncoding = "Accept-Encoding"
        static let xAppVersion = "X-APP-VERSION"
        static let XClientId = "X-CLIENT-ID"
        static let APIToken = "api-token"
        static let APIKey = "apikey"
    }
    
    struct ContentType {
        static let json = "application/json"
    }
    
    
    
    
}
