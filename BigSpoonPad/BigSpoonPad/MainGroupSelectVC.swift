//
//  MainGroupSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit
let reuseIdentifier = "mainGroupSelect"
let numOfSections = 1
let numOfOptions = 8
class MainGroupSelectVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    let titles = ["Sand Harbor, Lake Tahoe - California","Beautiful View of Manhattan skyline.","Watcher in the Fog","Great Smoky Mountains National Park, Tennessee","Most beautiful place"]

    
    @IBOutlet weak var groupSelectCollectionView: UICollectionView!
    @IBOutlet weak var firstItem: MainGroupSelectCell!
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
        var frame = self.firstItem.frame
        frame.origin.x = 0
        self.groupSelectCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    @IBOutlet weak var scrollNextButton: UIButton!
    @IBAction func scrollNextPressed() {
        var frame = self.firstItem.frame
        frame.origin.x = frame.origin.x + 170 * 7
        self.groupSelectCollectionView.scrollRectToVisible(frame, animated: true)
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
        if indexPath.item == 0 {
            self.firstItem = cell
        }
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
