//
//  BaseMapViewController.swift
//  carpino-passenger-ios-swift
//
//  Created by ali on 1/22/20.
//  Copyright © 2020 carpino corp. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import MaterialProgressBar
import RxSwift
import MarqueeLabel
import BRYXBanner


class BaseMapViewController: UIViewController {
    
    @IBOutlet weak var addressBarView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressMaterialProgressBarView: UIView!
    @IBOutlet weak var originMarkerButton: UIButton!
    @IBOutlet weak var destinationMarkerButton: UIButton!
    @IBOutlet weak var secondDestinationMarkerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addressNameLabel: MarqueeLabel!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    var cameraIsAnimating: Bool = false
    let network: NetworkManager = NetworkManager.sharedInstance
    
    var originMarker = GMSMarker()
    var destinationMarker = GMSMarker()
    var destinationMarker2 = GMSMarker()
    var destinationMarker3 = GMSMarker()
    var destinationMarker4 = GMSMarker()
    
    var originAddressView = AddressView()
    var destination1AddressView = AddressView()
    var destination2AddressView = AddressView()
    var destination3AddressView = AddressView()
    var destination4AddressView = AddressView()
    
    
    
    var goingToPushViewController = false
    let addressMaterialProgressBar = LinearProgressBar()
    var APIDisposableReverse: Disposable?
    
    var centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var originCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var destinationCoordiante: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var secondDestinationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var currentLocation: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 35.700753, longitude: 51.385837)
    var locationManager = CLLocationManager()
    
    var layer = CAShapeLayer()
    var layer2 = CAShapeLayer()
    
    var layer3 = CAShapeLayer()
    var layer4 = CAShapeLayer()
    
    var layer5 = CAShapeLayer()
    var layer6 = CAShapeLayer()
    
    var layer7 = CAShapeLayer()
    var layer8 = CAShapeLayer()
    
    
    let originMarqueeLabel = MarqueeLabel()
    let destination1MarqueeLabel = MarqueeLabel()
    let destination2MarqueeLabel = MarqueeLabel()
    let destination3MarqueeLabel = MarqueeLabel()
    let destination4MarqueeLabel = MarqueeLabel()
    
    func listenToNotificationCenterObservers() { }
    func setupViews() { }
    func setupDelegatesInitialization() { }
    func removeNotificationCenterObservers() { }
    func removeAllDisposables() { }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !goingToPushViewController {
            mapView.camera = GMSCameraPosition(target: currentLocation ?? CLLocationCoordinate2D(latitude: 35.700753, longitude: 51.385837), zoom: 18, bearing: 0, viewingAngle: 0)
        }
        goingToPushViewController = false
        
        locationManager.startUpdatingLocation()
        getAddressIfWeAreInGettingAddressState()
        listenToNotificationCenterObservers()
        disableButtons()
        hideAddressViews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        view.layoutIfNeeded()
        setupGesturesRecognizer()
        setupNavigationControllerUI()
        setupPinButtonsImages()
        initializeAddressNameLabel()
        bringUIElementsOnMapView()
        addressBarView.dropShadow()
        currentLocationButton.makeRound()
        currentLocationButton.dropShadow()
        mapView!.isMyLocationEnabled = true
        setupViews()
        setupDelegatesInitialization()
        locationManager.stopUpdatingLocation()
        startCheckingNetwork()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        CLog.i()
        setupMaterialProgressBarView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        CLog.i()
        APIDisposableReverse?.dispose()
        APIDisposableReverse = nil
        removeAllDisposables()
        removeNotificationCenterObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        CLog.i()
        if !goingToPushViewController {
            mapView.clear()
            mapView.removeFromSuperview()
            mapView = nil
        }
    }
    
    /** This function is for get CGPoint of the marker place in Mapview on the screen
     - parameters:
     - location : CLLocationCoordinate2D
 */
    func getScreenCGPoint(location: CLLocationCoordinate2D) -> (CGFloat, CGFloat) {
        let point = mapView.projection.point(for: location)
        let viewPoints = self.view.convert(point, from: mapView)
        //        let cgPoint = CGPoint(x: viewPoints.x, y: viewPoints.y)
        return (viewPoints.x, viewPoints.y)
    }
    
    /** This fucntion is for Draw Diagonal line between two CGPoint on the screen
    
     */
    func DrawPathWithAnimation(startPoint: CGPoint, endPoint: CGPoint, grayLayer: CAShapeLayer, pinkLayer: CAShapeLayer,  completion : @escaping () -> Void) {
        
        //Use CATransaction
        CATransaction.begin()
        
        //Set Layer
        grayLayer.lineWidth = 3
        grayLayer.strokeColor = UIColor.gray.cgColor
        grayLayer.fillColor = UIColor.clear.cgColor
        
        pinkLayer.lineWidth = 3
        pinkLayer.strokeColor = ColorConstants.primaryPinkColor.cgColor
        pinkLayer.fillColor = UIColor.clear.cgColor
        
        //Set Bezier Path
        let bezierPath = UIBezierPath()
        
        if startPoint.x == endPoint.x {
            bezierPath.move(to: startPoint)
            bezierPath.addLine(to: endPoint)
        } else {
            
            let topMidPoint: CGPoint = CGPoint(x: (endPoint.x + startPoint.x) / 2, y: endPoint.y)
            let bottomMidPoint: CGPoint = CGPoint(x: (endPoint.x + startPoint.x) / 2, y: startPoint.y)
            
            
            bezierPath.move(to: startPoint)
            bezierPath.addLine(to: bottomMidPoint)
            bezierPath.addLine(to: topMidPoint)
            bezierPath.addLine(to: endPoint)
            bezierPath.lineJoinStyle = .round
            bezierPath.stroke()
        }
        
        
        //Set Animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1
        animation.duration = 1.5 // seconds
        
        //Completion Block
        CATransaction.setCompletionBlock {
            print("Animation completed")
            pinkLayer.add(animation, forKey: "Line2")
            self.view.layer.addSublayer(pinkLayer)
            completion()
        }
        
        //Add path and animation
        grayLayer.path = bezierPath.cgPath
        pinkLayer.path = bezierPath.cgPath
        grayLayer.add(animation, forKey: "Line")
        CATransaction.commit()
        
        self.view.layer.addSublayer(grayLayer)
    }
    
    
    
    
    /// Put AddressView  near its Marker
    func putAddressViewInScreen(point: CGPoint, addressView: AddressView){
        CLog.i()
        addressView.isHidden = false
        addressView.center = CGPoint(x: point.x + addressView.frame.width/2, y: point.y + addressView.frame.height/2 + 10)
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(addressView)
        }, completion: nil)
    }
    
    /// Hide address Views without any animation
    func hideAddressViews(){
        CLog.i()
        originAddressView.isHidden = true
        destination1AddressView.isHidden = true
        destination2AddressView.isHidden = true
        destination3AddressView.isHidden = true
        destination4AddressView.isHidden = true
    }
    
    /// Draw line between Markers and Make & put addressViews near markers
    func drawLineAndPutAddressViews() {
        CLog.i()
        if originMarker.map != nil && destinationMarker.map != nil {
            let (originX, originY) = getScreenCGPoint(location: originMarker.position)
            let originCGPoint = CGPoint(x: originX, y: originY - originMarker.accessibilityFrame.height / 2)
            
            let (destinationX, destinationY) = getScreenCGPoint(location: destinationMarker.position)
            let destinationCGPoint = CGPoint(x: destinationX, y: destinationY - destinationMarker.accessibilityFrame.height / 2)
            
            
            
            DrawPathWithAnimation(startPoint: originCGPoint, endPoint: destinationCGPoint, grayLayer: self.layer, pinkLayer: self.layer2){
                self.putAddressViewInScreen(point: originCGPoint, addressView: self.originAddressView)
                self.putAddressViewInScreen(point: destinationCGPoint, addressView: self.destination1AddressView)
                
                
                if MainMapViewController.rideRequest.rideInfo.type != RideType.ROUNDTRIP.rawValue {
                    
                    switch MainMapViewController.rideRequest.rideInfo.extraDestinations?.count {
                        
                    case 1:
                        let (destinationX2, destinationY2) = self.getScreenCGPoint(location: self.destinationMarker2.position)
                        let destinationCGPoint2 = CGPoint(x: destinationX2, y: destinationY2 - self.destinationMarker2.accessibilityFrame.height / 2)
                        self.putAddressViewInScreen(point: destinationCGPoint2, addressView: self.destination2AddressView)
                        self.DrawPathWithAnimation(startPoint: destinationCGPoint, endPoint: destinationCGPoint2, grayLayer: self.layer3, pinkLayer: self.layer4){
                        }
                        
                        
                    case 2:
                        let (destinationX2, destinationY2) = self.getScreenCGPoint(location: self.destinationMarker2.position)
                        let destinationCGPoint2 = CGPoint(x: destinationX2, y: destinationY2 - self.destinationMarker2.accessibilityFrame.height / 2)
                        self.DrawPathWithAnimation(startPoint: destinationCGPoint, endPoint: destinationCGPoint2, grayLayer: self.layer3, pinkLayer: self.layer4){
                            self.putAddressViewInScreen(point: destinationCGPoint2, addressView: self.destination2AddressView)
                            
                            let (destinationX3, destinationY3) = self.getScreenCGPoint(location: self.destinationMarker3.position)
                            let destinationCGPoint3 = CGPoint(x: destinationX3, y: destinationY3 - self.destinationMarker3.accessibilityFrame.height / 2)
                            self.DrawPathWithAnimation(startPoint: destinationCGPoint2, endPoint: destinationCGPoint3, grayLayer: self.layer5, pinkLayer: self.layer6){
                                self.putAddressViewInScreen(point: destinationCGPoint3, addressView: self.destination3AddressView)
                            }
                            
                            
                        }
                        
                    case 3:
                        
                        let (destinationX2, destinationY2) = self.getScreenCGPoint(location: self.destinationMarker2.position)
                        let destinationCGPoint2 = CGPoint(x: destinationX2, y: destinationY2 - self.destinationMarker2.accessibilityFrame.height / 2)
                        self.DrawPathWithAnimation(startPoint: destinationCGPoint, endPoint: destinationCGPoint2, grayLayer: self.layer3, pinkLayer: self.layer4){
                            self.putAddressViewInScreen(point: destinationCGPoint2, addressView: self.destination2AddressView)
                            
                            let (destinationX3, destinationY3) = self.getScreenCGPoint(location: self.destinationMarker3.position)
                            let destinationCGPoint3 = CGPoint(x: destinationX3, y: destinationY3 - self.destinationMarker3.accessibilityFrame.height / 2)
                            self.DrawPathWithAnimation(startPoint: destinationCGPoint2, endPoint: destinationCGPoint3, grayLayer: self.layer5, pinkLayer: self.layer6){
                                self.putAddressViewInScreen(point: destinationCGPoint3, addressView: self.destination3AddressView)
                                
                                let (destinationX4, destinationY4) = self.getScreenCGPoint(location: self.destinationMarker4.position)
                                let destinationCGPoint4 = CGPoint(x: destinationX4, y: destinationY4 - self.destinationMarker4.accessibilityFrame.height / 2)
                                self.DrawPathWithAnimation(startPoint: destinationCGPoint3, endPoint: destinationCGPoint4, grayLayer: self.layer7, pinkLayer: self.layer8){
                                    
                                    self.putAddressViewInScreen(point: destinationCGPoint4, addressView: self.destination4AddressView)
                                }
                                
                                
                            }
                        }
                        
                        
                        
                    default:
                        break
                    }
                }
            }
        }
        MainMapViewController.shouldDraw = false
    }
    
    /// Start checking Network reachability of User
    func startCheckingNetwork() {
        CLog.i()
        
        network.reachability.whenUnreachable = { _ in
            CLog.i("Netowk Lost")
            DispatchQueue.main.async {
                self.showNetworkErrorBanner()
            }
        }
        
        NetworkManager.isUnreachable { _ in
            CLog.i("Netowk Lost")
            DispatchQueue.main.async {
                self.showNetworkErrorBanner()
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
    
    
    /// This fucntion is for moving camera to current location  with animation
    func animateCameraToCurrentLocation() {
        CLog.i()
        cameraIsAnimating = true
        if let myPosition = currentLocation {
            CLog.i("current location => \(myPosition)")
            mapView.camera = GMSCameraPosition(target: myPosition, zoom: 18, bearing: 0, viewingAngle: 0)
        } else {
            CLog.e("NO LOCATION FOUND YET")
        }
        locationManager.stopUpdatingLocation()
    }
    
    
    /** This fucntion is for moving camera to position with animation
     - parameters:
     - position: CLLocationCoordinate2D
     */
    func animateCameraToLocation(position: CLLocationCoordinate2D) {
        CLog.i()
        cameraIsAnimating = true
        DispatchQueue.main.async {
            CLog.i()
            self.mapView.animate(toLocation: position)
            self.mapView.animate(toZoom: 17)
        }
    }
    
       /** This function is for moving to top of the location with animation
        - parameters:
        - latLng : LatLng
    */
    func animateMapToTopFromLocation(latLng: LatLng) {
        CLog.i()
        cameraIsAnimating = true
        mapView.animate(to: .init(latitude: latLng.lat! + 0.005, longitude: latLng.lon!, zoom: 16))
    }
    
    
       /// This function is for setting the markers in bound of map view and show them all in screen
    func setMarkersInBoundOfMapView() {
        CLog.i()
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(originMarker.position)
        bounds = bounds.includingCoordinate(destinationMarker.position)
  
        switch MainMapViewController.rideRequest.rideInfo.extraDestinations?.count {
        case 1:
            bounds = bounds.includingCoordinate(destinationMarker2.position)
            
            CLog.i("Distance => \(abs(originMarker.position.latitude - destinationMarker.position.latitude) + abs(destinationMarker2.position.latitude - destinationMarker.position.latitude))")
            
            if abs(originMarker.position.latitude - destinationMarker.position.latitude) + abs(destinationMarker2.position.latitude - destinationMarker.position.latitude) > 0.005 {
                if originMarker.position.latitude < destinationMarker.position.latitude {
                    if destinationMarker2.position.latitude < originMarker.position.latitude {
                        bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: destinationMarker2.position.latitude - 0.01, longitude: destinationMarker2.position.longitude))
                    } else {
                        bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: originMarker.position.latitude - 0.01, longitude: originMarker.position.longitude))
                    }
                } else {
                    if destinationMarker2.position.latitude < destinationMarker.position.latitude {
                        bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: destinationMarker2.position.latitude - 0.01, longitude: destinationMarker2.position.longitude))
                    } else {
                        bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: destinationMarker.position.latitude - 0.01, longitude: destinationMarker.position.longitude))
                    }
                }
                
            }
            
            
        case 2:
            bounds = bounds.includingCoordinate(destinationMarker2.position)
            bounds = bounds.includingCoordinate(destinationMarker3.position)
            
        case 3:
            bounds = bounds.includingCoordinate(destinationMarker2.position)
            bounds = bounds.includingCoordinate(destinationMarker3.position)
            bounds = bounds.includingCoordinate(destinationMarker4.position)
            
        default:
            CLog.i("Distance => \(abs(originMarker.position.latitude - destinationMarker.position.latitude))")
            if abs(originMarker.position.latitude - destinationMarker.position.latitude) > 0.005 {
                if originMarker.position.latitude < destinationMarker.position.latitude {
                    bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: originMarker.position.latitude - 0.01, longitude: originMarker.position.longitude))
                } else {
                    bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: destinationMarker.position.latitude - 0.01, longitude: destinationMarker.position.longitude))
                }
            }
        }
        mapView.setMinZoom(1, maxZoom: 15)
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        mapView.setMinZoom(1, maxZoom: 25)
        mapView.padding.top = 100
        mapView.animate(with: update)
    }
    
    /// This function is for stopping the animation of top bar  progressView
    func stopProgressBarAnimation () {
        CLog.i()
        addressMaterialProgressBar.isHidden = true
        addressMaterialProgressBar.stopAnimating()
    }
    
    /// This function is for enabling all pin buttons
    func enableButtons() {
        CLog.i()
        self.originMarkerButton.isEnabled = true
        self.destinationMarkerButton.isEnabled = true
        self.secondDestinationMarkerButton.isEnabled = true
    }
    
    
    /// This function is for disabling all pin buttons
    func disableButtons() {
        CLog.i()
        originMarkerButton.isEnabled = false
        destinationMarkerButton.isEnabled = false
        secondDestinationMarkerButton.isEnabled = false
    }
    
    /// This function is for show top bar progress view and start its animation
    func showProgressBarAnimation() {
        CLog.i()
        if self.addressMaterialProgressBar.isHidden == true {
            self.setAddressOfAddressBar(address: StringHelper.MainMap.getLoadingAddress())
            self.addressMaterialProgressBar.startAnimating()
            self.addressMaterialProgressBar.isHidden = false
        }
    }
    
    
    func getAddressIfWeAreInGettingAddressState() {
        CLog.i()
        if (addressNameLabel.text == StringHelper.MainMap.getLoadingAddress())
        {
            stopProgressBarAnimation()
            showProgressBarAnimation()
            getAddressAndSetAddressBar(position: mapView.camera)
        }
    }
    
    func setupGesturesRecognizer() {
        CLog.i()
        let tap = UITapGestureRecognizer(target: self, action: #selector(addressBarDidTap(_:)))
        
        addressNameLabel.addGestureRecognizer(tap)
    }
}

//MARK: - Actions
extension BaseMapViewController {
    
    
    @IBAction func addressBarDidTap(_ sender: Any) {
        CLog.i()
        goingToPushViewController = true
        SegueHelper.pushViewController(sourceViewController: self, destinationViewController: SearchViewController.instantiateFromStoryboardName(storyboardName: .Search))
    }
    
    @IBAction func showCurrentLocationButtonDidTap(_ sender: Any) {
        CLog.i()
        locationManager.startUpdatingLocation()
    }
}

//MARK: - Setup UI Functions
extension BaseMapViewController {
    
    func setupPinButtonsImages() {
        if ValueKeeper.language == "fa" {
            originMarkerButton.setImage(UIImage(named: "originPin"), for: .normal)
            destinationMarkerButton.setImage(UIImage(named: "destinationPin"), for: .normal)
            secondDestinationMarkerButton.setImage(UIImage(named: "secondDestinationPin"), for: .normal)
        } else {
            originMarkerButton.setImage(UIImage(named: "originPinEN"), for: .normal)
            destinationMarkerButton.setImage(UIImage(named: "destinationPinEN"), for: .normal)
            secondDestinationMarkerButton.setImage(UIImage(named: "secondDestinationPinEN"), for: .normal)
        }
    }
    
    func setupNavigationControllerUI() {
        CLog.i()
        navigationController?.isNavigationBarHidden = true
    }
    
    func initializeAddressNameLabel() {
        CLog.i()
        addressNameLabel.text = StringHelper.MainMap.getLoadingAddress()
        addressNameLabel.type = .right
        addressNameLabel.animationCurve = .easeInOut
        addressNameLabel.tapToScroll = true
    }
    
    func setAddressOfAddressBar(address: String) {
        CLog.i()
        self.addressNameLabel.text = address
    }
    
    func bringUIElementsOnMapView() {
        CLog.i()
        mapView.bringSubviewToFront(addressBarView)
        mapView.bringSubviewToFront(currentLocationButton)
        mapView.bringSubviewToFront(originMarkerButton)
        mapView.bringSubviewToFront(destinationMarkerButton)
        mapView.bringSubviewToFront(secondDestinationMarkerButton)
    }
    
    func setupMaterialProgressBarView() {
        CLog.i()
        addressMaterialProgressBar.frame = CGRect(x: 0, y: 0, width: addressMaterialProgressBarView.frame.width, height: 3)
        addressMaterialProgressBar.layoutIfNeeded()
        addressMaterialProgressBar.progressBarColor = ColorConstants.primaryPinkColor
        addressMaterialProgressBarView.layoutIfNeeded()
        addressMaterialProgressBarView.addSubview(addressMaterialProgressBar)
    }
}

extension BaseMapViewController {
    
    
    /** This function calls reverse  API and get the address and set the top bar addressView address
- parameters:
     - pposition: GMSCameraPosition
 */
    func getAddressAndSetAddressBar(position: GMSCameraPosition) {
        CLog.i()
        APIDisposableReverse?.dispose()
        APIDisposableReverse = nil
        APIDisposableReverse = APIClient.getReverse(lat: position.target.latitude, long: position.target.longitude)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { (data) in
                CLog.i("getReverse => onNext =>  \(data.result)")
                DispatchQueue.main.async {
                    self.setAddressOfAddressBar(address: data.result)
                    self.stopProgressBarAnimation()
                    self.enableButtons()
                }
            }, onError: { (e) in
                CLog.e("getReverse => onError => \(e)")
                DispatchQueue.main.async {
                    self.setAddressOfAddressBar(address: StringHelper.APIFailError.getData())
                    self.stopProgressBarAnimation()
                }
            })
    }
}

//MARK: - Map View Delegate Functions
extension BaseMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLog.i()
        guard locations.first != nil else {
            locationManager.stopUpdatingLocation()
            return
        }
        currentLocation = locations.first?.coordinate
        originCoordinate = locations.first!.coordinate
        
        animateCameraToCurrentLocation()
        cameraIsAnimating = false
        
        locationManager.stopUpdatingHeading()
    }
    
    @nonobjc func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        CLog.i()
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
}
extension BaseMapViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        CLog.i()
        self.centerCoordinate = position.target
    }
}
