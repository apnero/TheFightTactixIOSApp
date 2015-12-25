import UIKit
import IOStickyHeader
import DZNEmptyDataSet
import FoldingTabBar

class InformationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, YALTabBarInteracting  {
    
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
        
        
        
        var sum = 0
        for card in CloudQueries.vuserPunchCards {
            sum += card.credits!
        }
        
        let remaining = sum - CloudQueries.vuserClassHistory.count
        
        classesAttended.text = "\(CloudQueries.vuserClassHistory.count)"
        creditsPurchased.text = "\(sum)"
        creditsRemaining.text = "\(remaining)"
        
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
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if (indexPath.row == 0) {
           let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
            return cell
        } else {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell2", forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 105);
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! IOSectionHeader
            cell.lblText.text = "Information"
            return cell
        case IOStickyHeaderParallaxHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! IOParallaxHeader
            return cell
        default:
            fatalError("unexpected element kind")
            //assert(false, "Unexpected element kind")
        }
    }
    

    
}
