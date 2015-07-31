//
//  GroupItemSelectVC.swift
//  BigSpoonPad
//
//  Created by Qiao Liang on 28/7/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

import UIKit

class GroupItemSelectVC: UIViewController, TabCollectionProtocol , UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var selectedGroupDescription: UILabel!
    @IBOutlet weak var selectedGroupLabel: UILabel!
    let titles = ["Terror", "Fresh", "Texture", "Rich", "Sparkling", "Sour", "Scent", "Unique"]
    let descriptions = ["Single-estate teas, whole leaves, exquisite iced teas", "Mild fruity notes and cold-pressed juice concentrates", "Handmade fruit jellies, mochi textures, natural fibers", "Intensity and creaminess of milk tea",
        "Single-estate teas, whole leaves, exquisite iced teas", "Mild fruity notes and cold-pressed juice concentrates", "Handmade fruit jellies, mochi textures, natural fibers", "Intensity and creaminess of milk tea"]
    let items = ["Royal Milk Tea", "Afternoon Milk Tea", "Thai Shaved Ice Milk Tea", "Espresso Milk Tea", "Royal Milk Tea", "Afternoon Milk Tea", "Thai Shaved Ice Milk Tea", "Espresso Milk Tea"]
    let itemDescription = ["Mild fruity notes and cold-pressed juice concentrates", "Floral blossoms and nectarine pairings", "Accentuated refreshing flavors with bubbles", "Intensity and creaminess of milk tea","Mild fruity notes and cold-pressed juice concentrates", "Floral blossoms and nectarine pairings", "Accentuated refreshing flavors with bubbles", "Intensity and creaminess of milk tea"]
    
    let reuseIdentifier = "ItemSelectCell"
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    let numOfSections = 1
    let numOfOptions = 8
    @IBOutlet var itemSelectCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemSelectCollectionView.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    var tabsController: GroupTabCollectionVC!
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TabsContained" {
            tabsController = segue.destinationViewController as! GroupTabCollectionVC
            tabsController.delegate = self
        }
    }
    
    func tabSelected(controller:GroupTabCollectionVC, cellSelcted:GroupTabCollectionViewCell) {
        // TODO: update items select collection view
    }
    
    @IBOutlet weak var scrollBackButton: UIButton!
    @IBAction func scrollBackPressed() {
        var lastItemIndex = NSIndexPath(forItem: 0, inSection: 0)
        self.itemSelectCollectionView.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Right, animated: true)
    }
    
    @IBOutlet weak var scrollNextButton: UIButton!
    @IBAction func scrollNextPressed() {
        var lastItemIndex = NSIndexPath(forItem: numOfOptions - 1, inSection: 0)
        self.itemSelectCollectionView.scrollToItemAtIndexPath(lastItemIndex, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numOfSections
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfOptions
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ItemSelectCell
        cell.itemName.text = self.items[indexPath.row]
        cell.itemDescriptionLabel.text = self.itemDescription[indexPath.row]
        cell.itemPriceLabel.text = "$5.9, $6.3"
        
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
//        performSegueWithIdentifier("MainToItem", sender: nil);
    }

}
