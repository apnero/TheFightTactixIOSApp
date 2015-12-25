import UIKit
import IOStickyHeader
import DZNEmptyDataSet
import LNRSimpleNotifications
import FoldingTabBar

class ScheduleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, YALTabBarInteracting  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var creditsRemaining: UILabel!
    @IBOutlet weak var creditsPurchased: UILabel!
    @IBOutlet weak var classesAttended: UILabel!
        
    let headerNib = UINib(nibName: "IOParallaxHeader", bundle: NSBundle.mainBundle())
    var section: Array<String> = []
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.backgroundColor = UIColor.whiteColor()
//        gradientLayer.frame = CGRectMake(0,130, collectionView.bounds.size.width, collectionView.bounds.size.height)// collectionView.bounds
//        
//        let color1 = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9).CGColor as CGColorRef
//        let color2 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).CGColor as CGColorRef
//        gradientLayer.colors = [color1, color2, color1, color2, color1]
//        gradientLayer.locations = [0.1, 0.3, 0.5, 0.7, 0.9]
//        gradientLayer.opacity = 0.6
//        
//        gradientLayer.startPoint = CGPointMake(0.0,0.0)
//        gradientLayer.endPoint = CGPointMake(1.0,1.0)
//        collectionView.layer.addSublayer(gradientLayer)
        
        var sum = 0
        for card in CloudQueries.vuserPunchCards {
            sum += card.credits!
        }
        
        let remaining = sum - CloudQueries.vuserClassHistory.count
        
        classesAttended.text = "\(CloudQueries.vuserClassHistory.count)"
        creditsPurchased.text = "\(sum)"
        creditsRemaining.text = "\(remaining)"
        
        self.setupCollectionView()
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetDelegate = self
        
        LNRSimpleNotifications.sharedNotificationManager.notificationsBackgroundColor = UIColor.blackColor()
        LNRSimpleNotifications.sharedNotificationManager.notificationsTitleTextColor = UIColor.whiteColor()
        LNRSimpleNotifications.sharedNotificationManager.notificationsBodyTextColor = UIColor.whiteColor()
        LNRSimpleNotifications.sharedNotificationManager.notificationsSeperatorColor = UIColor.whiteColor()
        LNRSimpleNotifications.sharedNotificationManager.notificationsIcon = UIImage(named: "iostabbarwhite")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        if let layout: IOStickyHeaderFlowLayout = self.collectionView.collectionViewLayout as? IOStickyHeaderFlowLayout {
            layout.parallaxHeaderReferenceSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 130)
            layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 0)
            layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, layout.itemSize.height)
            layout.parallaxHeaderAlwaysOnTop = true
            layout.disableStickyHeaders = true
            self.collectionView.collectionViewLayout = layout
        }
        
        self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.collectionView.registerNib(self.headerNib, forSupplementaryViewOfKind: IOStickyHeaderParallaxHeader, withReuseIdentifier: "header")
    }
    

    
    //MARK: UICollectionViewDataSource & UICollectionViewDelegate
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return self.section.count
//    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CloudQueries.vcurrentSchedule.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell: MeetingCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MeetingCell
        
        cell.set(indexPath.row)
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 50);
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! IOSectionHeader
            cell.lblText.text = "Schedule"
            return cell
        case IOStickyHeaderParallaxHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! IOParallaxHeader
            return cell
        default:
            fatalError("unexpected element kind")
            //assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MeetingCell
        
        var params = [String:NSDate]()
        params["date"] = CloudQueries.vcurrentSchedule[indexPath.row].date
        
        if cell.status.text == "Register" {
            CloudCalls.registerForClass(params)
            cell.status.text  = "Registered"
            cell.status.textColor = UIColor.blueColor()
            LNRSimpleNotifications.sharedNotificationManager.showNotification("Registered", body: "You have registered for class.", callback: { () -> Void in
                LNRSimpleNotifications.sharedNotificationManager.dismissActiveNotification({ () -> Void in print("Dismissed")})
            })
        }
        else if cell.status.text == "Registered" {
            CloudCalls.unRegisterForClass(params)
            cell.status.text = "Register"
            cell.status.textColor = UIColor.blackColor()
            LNRSimpleNotifications.sharedNotificationManager.showNotification("Un-Registered", body: "You have cancelled your class registration.", callback: { () -> Void in
                LNRSimpleNotifications.sharedNotificationManager.dismissActiveNotification({ () -> Void in print("Dismissed")})
            })        }
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "There Are No Classes Scheduled"
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func verticalOffsetForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return 75.0
    }
    
    
    func extraLeftItemDidPress() {
        print("leftItem pressed")
        UIApplication.sharedApplication().openURL(NSURL(string: "sms://2035454694")!)
    
    }
    
    func extraRightItemDidPress() {
        //print("right pressed")
        UIApplication.sharedApplication().openURL(NSURL(string: "https://kravmagact.sites.zenplanner.com/sign-up-now.cfm")!)
        
    }
    
    func tabBarViewDidCollapse() {
        //print ("collapsed")
    }

}
