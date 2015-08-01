//
//  ColorNameCell.m
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import "ColorNameCell.h"
#import "ColorName.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorFromHex.h"

@implementation ColorNameCell

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
    self.colorName = nil;
}

- (void)setColorName:(ColorName *)colorName
{
    _colorName = colorName;
    if (colorName != nil)
    {
        self.backgroundColor = [UIColor colorFromHexString:@"#F5CD91"];
        //colorName.color;
        self.nameLabel.text = colorName.name;
    }
}


@end
