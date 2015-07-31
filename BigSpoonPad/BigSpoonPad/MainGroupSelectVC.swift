//
//  MainGroupSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class MainGroupSelectVC: UIViewController, UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let reuseIdentifier = "mainGroupSelect"
    let numOfSections = 1
    let numOfOptions = 8
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    let titles = ["Sand Harbor, Lake Tahoe - California","Beautiful View of Manhattan skyline.","Watcher in the Fog","Great Smoky Mountains National Park, Tennessee","Most beautiful place"]

    
    @IBOutlet weak var groupSelectCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupSelectCollectionView.backgroundColor = UIColor.clearColor();
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backPressed() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }


    @IBOutlet weak var scrollBackButton: UIButton!
    @IBAction func scrollBackPressed() {
        var lastItemIndex = NSIndexPath(forItem: 0, inSection: 0)
        self.groupSelectCollectionView.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Right, animated: true)
    }
    
    @IBOutlet weak var scrollNextButton: UIButton!
    @IBAction func scrollNextPressed() {
        var lastItemIndex = NSIndexPath(forItem: numOfOptions - 1, inSection: 0)
        self.groupSelectCollectionView.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numOfSections
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfOptions
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainGroupSelectCell
        cell.groupTitle.text = self.titles[indexPath.row % 5]
        let curr = indexPath.row % 5  + 1
        let imgName = "pin\(curr).jpg"
        cell.GroupOptionImage.image = UIImage(named: imgName)

        return cell

    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 160, height: 320)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        performSegueWithIdentifier("MainToItem", sender: nil);
    }
    
}
