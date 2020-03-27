

import Foundation
import Alamofire
import RxSwift


class APIClient {
    
//    static func [FunctioName]([InputName] : Type, .... , completion: @escaping (Result<[ModelName], AFError>)->Void){
//        AF.request(TestBussiness.[CaseName]([InputName] : Input), ....).responseDecodable{ (response: DataResponse<[ModelName],AFError>) in
//            completion(response.result)
//        }
//    }
   


//    static func [FunctioName]([InputName] : Type, .... , ) -> Observable<[ModelName]> {
//        return request(TestBussiness.[CaseName]([InputName] : Input), .....)
//    }
    
    
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        CLog.i("FUNCTION : request")
      
        return Observable<T>.create { observer  in
            
            CLog.i("OBSERVABLE CREATE ")
            
            _ = AF.request(urlConvertible, interceptor: NetworkInterceptor()).validate().responseDecodable
                { (response: DataResponse<T,AFError>) in
                    
                    switchLabel: switch response.result {
                        
                        case .success(let value):
                            
                            CLog.i("SUCSESS => \(String(describing: response.request))")
                            CLog.i("SUCSESS => \(String(describing: response.response?.statusCode))")
                            observer.onNext(value)
                            observer.onCompleted()
       
                        
                        case .failure(let error):
                            if (response.response?.statusCode == HTTPCodes.SERVICE_UNAVAILABLE_ERROR) {
                                break switchLabel
                            }
                            if  response.response?.statusCode == HTTPCodes.NO_CONTENT {
                                CLog.i("SUCSESS => \(String(describing: response.response?.statusCode))")
                                if T.self == OngoingRide.self{
                                    let cError = CError()
                                    observer.onError(NetworkError(webServerErrorCode: HTTPCodes.NO_CONTENT, cError: cError))
                                }else {
                                    observer.onNext(EmptyResponse() as! T)
                                    observer.onCompleted()
                                }
                            } else if response.response?.statusCode == HTTPCodes.SUCCESS {
                                if error.isResponseSerializationError {
                                    switch error {
                                        case .responseSerializationFailed(let reason):
                                            CLog.i("error => \(reason)")
                                            switch reason {
                                                case .inputDataNilOrZeroLength:
                                                    CLog.i("inputDataNilOrZeroLength")
                                                    CLog.i("SUCSESS => \(String(describing: response.response?.statusCode))")
                                                    observer.onNext(EmptyResponse() as! T)
                                                    observer.onCompleted()
                                                default:
                                                    break
                                            }
                                        default:
                                            break
                                    }
                                }
                                CLog.e("ERROR => \(String(describing: response.response?.statusCode))")
                                CLog.e("ERROR => \(String(describing: response.request))")
                                CLog.e("ERROR => \(String(describing: response.request?.httpBody?.base64EncodedString()))")
                                CLog.e("\(error)")
                                
                                if let data = response.data {
                                    do {
                                        let json = String(data: data, encoding: String.Encoding.utf8)
                                        CLog.e("\(String(describing: json))")
                                    
                                        let cError: CError = try JSONDecoder().decode(CError.self, from: (json?.data(using: String.Encoding.utf8))!)
                                        observer.onError(NetworkError(webServerErrorCode: response.response!.statusCode, cError: cError))
                                    } catch {
                                        CLog.e("CANNOT CAST ERROR RESPONSE TO CError")
                                    }
                                } else {
                                    CLog.e("NO ERROR DATA RESPONSE TO DECODE")
                                }
                                observer.onError(error)
                            } else {
                                CLog.e("ERROR => \(String(describing: response.response?.statusCode))")
                                CLog.e("ERROR => \(String(describing: response.request))")
                                CLog.e("ERROR => \(String(describing: response.request?.httpBody?.base64EncodedString()))")
                                CLog.e("\(error)")
                                if let data = response.data {
                                    do {
                                        let json = String(data: data, encoding: String.Encoding.utf8)
                                        CLog.e("\(String(describing: json))")
                                    
                                        let cError: CError = try JSONDecoder().decode(CError.self, from: (json?.data(using: String.Encoding.utf8))!)
                                        observer.onError(NetworkError(webServerErrorCode: response.response!.statusCode, cError: cError))
                                    } catch {
                                        CLog.e("CANNOT CAST ERROR RESPONSE TO CError")
                                    }
                                } else {
                                    CLog.e("NO ERROR DATA RESPONSE TO DECODE")
                                }
                                observer.onError(error)
                            }
                        } // end switch result
                } // end AF request
            
            return Disposables.create()
            } // end Observable.Create
    }
    
    
    
    
}




