//
//  ColorCollectionViewController.h
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorCollectionViewController : UIViewController
@property (nonatomic, strong) NSMutableArray * sectionModifiers;
@property (nonatomic) int currentSelection;
- (BOOL) isComplete;
@end
