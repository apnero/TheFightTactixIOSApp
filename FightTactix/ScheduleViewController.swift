import UIKit
import IOStickyHeader

class ScheduleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let headerNib = UINib(nibName: "IOParallaxHeader", bundle: NSBundle.mainBundle())
    var section: Array<String> = []
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.section = [
            "City 1",
            "City 2",

        ]
        
        collectionView.backgroundColor = UIColor.whiteColor()
        gradientLayer.frame = CGRectMake(0,150, collectionView.bounds.size.width, collectionView.bounds.size.height)// collectionView.bounds
        
        let color1 = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8).CGColor as CGColorRef
        let color2 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.2).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color1]
        gradientLayer.locations = [0.2, 0.4, 0.6]
        gradientLayer.opacity = 0.5
        
        gradientLayer.startPoint = CGPointMake(0.0,0.0)
        gradientLayer.endPoint = CGPointMake(1.0,1.0)
        collectionView.layer.addSublayer(gradientLayer)
        
        self.setupCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        if let layout: IOStickyHeaderFlowLayout = self.collectionView.collectionViewLayout as? IOStickyHeaderFlowLayout {
            layout.parallaxHeaderReferenceSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, 150)
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
        return CloudQueries.vuserClassHistory.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HistoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HistoryCell
        
        cell.set(indexPath.row)
        //let obj = self.section[indexPath.section][indexPath.row]
        
        //cell.lblTitle.text = obj
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 50);
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
//        case IOStickyHeaderParallaxHeader:
//            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! IOGrowHeader
//            return cell
        case IOStickyHeaderParallaxHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! IOParallaxHeader
            return cell
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
}
