//
//  ModifierOption.h
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModifierOption : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic) double price;
@property (nonatomic) BOOL selected;

 + (ModifierOption*)optionWithPrice:(float)price name:(NSString*)name;
@end
