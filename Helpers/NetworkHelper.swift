import Foundation
import Reachability
import Network
import UIKit
import BRYXBanner


class CheckNetwork {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    
    /// Start checking Network reachability of User
    class func startCheckingNetwork(){
        CLog.i()
        
        network.reachability.whenUnreachable = { _ in
            CLog.i("Netowk Lost")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self.showNetworkErrorBanner()
                }
            }
        }
        
        NetworkManager.isUnreachable { _ in
            CLog.i("Netowk Lost")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self.showNetworkErrorBanner()
                }
            }
            
        }
    }
    
    /// Show Network problem Error to the User
    func showNetworkErrorBanner() {
        let banner = Banner(title: "خطا در اتصال به اینترنت", subtitle: "لطفا اتصال خود به اینترنت را بررسی کنید.", image: UIImage(named: "NetworkProblem"), backgroundColor: .systemOrange)
        banner.titleLabel.textAlignment = .center
        banner.detailLabel.textAlignment = .center
        banner.titleLabel.font = FontHelper.getIRANSansMobileBold(size: 14)
        banner.detailLabel.font = FontHelper.getIRANSansMobile(size: 14)
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
    }
    
    
}



/// This class Manages the network checking
class NetworkManager: NSObject {
    
    var reachability: Reachability!
    
    // Create a singleton instance
    static let sharedInstance: NetworkManager = { return NetworkManager() }()
    
    
    override init() {
        super.init()
        
        // Initialise reachability
        do{
            reachability = try Reachability()
        } catch {
            return
        }
        
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
}
