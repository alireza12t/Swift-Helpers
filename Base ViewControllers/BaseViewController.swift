import Foundation
import Reachability
import Network
import UIKit
import BRYXBanner


class BaseViewController: UIViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCheckingNetwork()
    }
    
    
    func isUserInOngoingRide() -> Bool{
        return false
    }
    
    
    /// Start checking Network reachability of User
    func startCheckingNetwork(){
        CLog.i()
        
        network.reachability.whenUnreachable = { _ in
            CLog.i("Netowk Lost")
            DispatchQueue.main.async {
                self.showNetworkErrorBanner()
            }        }
        
        NetworkManager.isUnreachable { _ in
            CLog.i("Netowk Lost")
            DispatchQueue.main.async {
                self.showNetworkErrorBanner()
            }
            
        }
    }
    
    
    
    /// Show The notification that driver arrived to the User
    func showDriverArrivedNotification(){
        CLog.i()
        let banner = Banner(title: "کارپینو رسید !", subtitle: "مسافر گرامی راننده کارپینو به مبدا شما رسیده است", image: nil, backgroundColor: ColorConstants.primaryPinkColor)
        banner.titleLabel.textAlignment = .right
        banner.detailLabel.textAlignment = .right
        banner.titleLabel.font = FontHelper.getIRANSansMobileBold(size: 16)
        banner.detailLabel.font = FontHelper.getIRANSansMobile(size: 14)
        banner.position = .top
        //        banner.shadowOffset = UIOffset(horizontal: 1, vertical: 2)
        banner.shadowOpacity = .pi
        banner.frame.inset(by: UIEdgeInsets(top: 12, left: 18, bottom: 8, right: 18))
        banner.cornerRadius = 10
        banner.shadowColor = .darkGray
        banner.shadowRadius = 3
        //        shadowEdgeInsets: UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4) )
        
        banner.show(duration: 3.0)
    }
    
    
    /// Show The notification that passenger get in to the car to the User
    func showPassengerGetInNotification()
    {
        CLog.i()
        let banner = Banner(title: "شما در سفر هستید", subtitle: "مسافر گرامی شما با راننده کارپینو در سفر هستید. امیدواریم تجربه سفر خوبی داشته باشید.", image: nil, backgroundColor: ColorConstants.primaryPinkColor)
        banner.titleLabel.textAlignment = .right
        banner.detailLabel.textAlignment = .right
        banner.titleLabel.font = FontHelper.getIRANSansMobileBold(size: 16)
        banner.detailLabel.font = FontHelper.getIRANSansMobile(size: 14)
        //        banner.shadowOffset = UIOffset(horizontal: 1, vertical: 2)
        banner.shadowOpacity = .pi
        banner.frame.inset(by: UIEdgeInsets(top: 12, left: 18, bottom: 8, right: 18))
        banner.cornerRadius = 10
        banner.shadowColor = .darkGray
        banner.shadowRadius = 3
        
        banner.position = .top
        
        //        shadowEdgeInsets: UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4) )
        
        banner.show(duration: 3.0)
    }
    
    /// Show Custom error message to the User
    func showStatusBarErrorMessage(errorMessageStr: String)  {
        CLog.i()
        DispatchQueue.main.async {
            let banner = Banner(title: "", subtitle: errorMessageStr, image: nil, backgroundColor: .systemOrange)
            banner.preferredStatusBarStyle = .lightContent
            banner.detailLabel.textAlignment = .center
            banner.detailLabel.font = FontHelper.getIRANSansMobileBold(size: 14)
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
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
    
    
    func notifUserAboutNetwork(){
        DispatchQueue.main.async {
            self.showNetworkErrorBanner()
        }
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
