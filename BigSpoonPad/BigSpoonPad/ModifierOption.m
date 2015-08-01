//
//  ModifierOption.m
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

#import "ModifierOption.h"

@implementation ModifierOption

+ (ModifierOption*)optionWithPrice:(float)price name:(NSString*)name {
    ModifierOption *op = [[ModifierOption alloc] init];
    op.price = price;
    op.name = name;
    op.selected = false;
    return op;
}

@end
