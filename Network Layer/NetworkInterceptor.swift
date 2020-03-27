//
//  RetryRequestInterceptor.swift

import Foundation
import Alamofire


class NetworkInterceptor: Interceptor {
    
    // MARK: - RequestRetrier
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        CLog.e("\(error)")
        CLog.e("REQUEST RETRY COUNT => \(request.retryCount)")
        CLog.e("REQUEST URL => \(String(describing: request.request?.url))")
        
        if (request.retryCount > 5)
        {
            CLog.e("REQUEST RETRIED 5 TIMES")
            completion(.doNotRetry)
        }
        else
        {
            if let afError = error.asAFError
            {
                CLog.e("THIS IS ALAMOFIRE ERROR")
                if afError.isSessionTaskError
                {
                    CLog.e("SESSION TASK ERROR")
                    completion(.retryWithDelay(TimeInterval(5)))
                }
                else if let response = request.task?.response as? HTTPURLResponse
                {
                    CLog.e("RESPONSE CODE => \(response.statusCode)")
                    if response.statusCode == 500
                    {
                        CLog.e("SERVER UNAVAILABLE ERROR")
                        completion(.retry)
                    }
                    else
                    {
                        CLog.e("THIS IS NOT SERVER UN AVAILABLE")
                        completion(.doNotRetry)
                    }
                }
                else
                {
                    CLog.e("REQUEST IS NOT HTTP URL RESPONSE")
                    completion(.doNotRetry)
                }

            }
            
            else if let response = request.task?.response as? HTTPURLResponse
            {
                CLog.e("RESPONSE CODE => \(response.statusCode)")
                if response.statusCode == 500
                {
                    CLog.e("SERVER UNAVAILABLE ERROR")
                    completion(.retry)
                }
            }
            else
            {
                CLog.e("REQUEST IS NOT HTTP URL RESPONSE")
                completion(.doNotRetry)
            }
        }
    }
}
