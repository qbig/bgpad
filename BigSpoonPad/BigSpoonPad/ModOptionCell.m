//
//  ColorNameCell.m
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import "ModOptionCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorFromHex.h"


@implementation ModOptionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel.text = nil;
    
    self.layer.borderWidth = 2.0f;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 16;
    self.layer.borderColor = [UIColor colorFromHexString:@"#F5CD91"].CGColor;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel.text = nil;
    self.optionModel = nil;
}

- (void)setOptionModel:(ModifierOption *)optionMod
{
    _optionModel = optionMod;
    if (optionMod != nil)
    {
        if(optionMod.selected) {
            self.backgroundColor = [UIColor colorFromHexString:@"#F5CD91"];
        } else {
            self.backgroundColor = [UIColor clearColor];
        }

        self.nameLabel.text = optionMod.name;
    }
}


@end
