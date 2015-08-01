//
//  ModifierSection.h
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModifierOption.h"

@interface ModifierSection : NSObject
/*
 @interface ColorName : NSObject
 
 @property (nonatomic, strong) UIColor * color;
 @property (nonatomic, strong) NSString * name;
 
 + (ColorName*)colorNameWithColor:(UIColor*)color name:(NSString*)name;
 
 @end
 
 @interface ColorName (Random)
 
 + (ColorName*)randomColorName;
 
 @end

 */

@property (nonatomic, strong) NSString * uuid;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * modifierDescription;
@property (nonatomic) BOOL required;
@property (nonatomic) float price;
@property (nonatomic, strong) NSString * type; // TODO: use enum?
@property (nonatomic, strong) NSArray * options;
@property (nonatomic) int selectedOptionIndex;

+ (ModifierSection*) sectionWithDict: (NSDictionary*) dict;

@end
