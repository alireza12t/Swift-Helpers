import BRYXBanner
import Foundation

class DialogueHelper {

    
    static func showDriverArrivedNotification(){
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
    static func showPassengerGetInNotification()
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
    static func showStatusBarErrorMessage(errorMessageStr: String, _ color: UIColor = .systemOrange)  {
        CLog.i()
        DispatchQueue.main.async {
            let banner = Banner(title: "", subtitle: errorMessageStr, image: nil, backgroundColor: color)
            banner.preferredStatusBarStyle = .lightContent
            banner.detailLabel.textAlignment = .center
            banner.detailLabel.font = FontHelper.getIRANSansMobileBold(size: 14)
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
        }
    }
}
