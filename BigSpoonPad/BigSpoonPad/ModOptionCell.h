//
//  ColorNameCell.h
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModifierOption.h"

@class ColorName;

@interface ModOptionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) ModifierOption *optionModel;

@end
