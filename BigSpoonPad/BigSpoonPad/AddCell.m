//
//  AddCell.m
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import "AddCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorFromHex.h"

@implementation AddCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderWidth = 2.0f;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 16;
    self.layer.borderColor = [UIColor colorFromHexString:@"#F5CD91"].CGColor;
}


@end
