//
//  GroupTabCollectionVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 31/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

protocol TabCollectionProtocol {
    func tabSelected(controller:GroupTabCollectionVC, cellSelcted:GroupTabCollectionViewCell)
}

class GroupTabCollectionVC: UIViewController, UICollectionViewDelegate, UIScrollViewDelegate, NSObjectProtocol, UICollectionViewDataSource {
    let reuseIdentifier = "GroupTabCell"
    let charLength = 10
    let numOfSections = 1
    let numOfOptions = 8
    let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    let titles = ["Terror", "Fresh", "Texture", "Rich", "Sparkling", "Sour", "Scent", "Unique"]
    @IBOutlet var tabCollectionView: UICollectionView!
    var delegate: TabCollectionProtocol!
    @IBOutlet weak var tabSelectIndicator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabCollectionView.backgroundColor = UIColor.clearColor();
    }
    
    @IBOutlet weak var scrollBackButton: UIButton!
    @IBAction func scrollBackPressed() {
        var lastItemIndex = NSIndexPath(forItem: 0, inSection: 0)
        self.tabCollectionView.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Right, animated: true)
    }
    
    @IBOutlet weak var scrollNextButton: UIButton!
    @IBAction func scrollNextPressed() {
        var lastItemIndex = NSIndexPath(forItem: numOfOptions - 1, inSection: 0)
        self.tabCollectionView.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numOfSections
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfOptions
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GroupTabCollectionViewCell
        cell.groupNameLabel.text = self.titles[indexPath.row % 5]
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: count(titles[indexPath.item]) * charLength + 4, height: 21)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GroupTabCollectionViewCell
        println("Tab selected; \(indexPath.item)")
        self.delegate.tabSelected(self, cellSelcted:cell)
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations:  {
            var destinIndicatorFrame = self.tabSelectIndicator.frame
            destinIndicatorFrame.origin.x = cell.frame.origin.x
            destinIndicatorFrame.size.width = cell.frame.size.width
            self.tabSelectIndicator.frame = destinIndicatorFrame
            }, completion: {finished in println("indicator anim done")})
    }
}
