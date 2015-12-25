//
//  HistoryViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/10/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import IOStickyHeader
import DZNEmptyDataSet
import FoldingTabBar

class HistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, YALTabBarInteracting  {
    
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
        self.collectionView.emptyDataSetSource = self
        self.collectionView.emptyDataSetDelegate = self
        

        
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
        return CloudQueries.vuserClassHistory.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell: HistoryCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HistoryCell
        
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
            cell.lblText.text = "Class History"
            return cell
        case IOStickyHeaderParallaxHeader:
            let cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! IOParallaxHeader
            return cell
        default:
            fatalError("unexpected element kind")
            //assert(false, "Unexpected element kind")
        }
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "There are no past classes on your Account."
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
        print("right pressed")
        UIApplication.sharedApplication().openURL(NSURL(string: "https://kravmagact.sites.zenplanner.com/sign-up-now.cfm")!)
        
    }
    
}
