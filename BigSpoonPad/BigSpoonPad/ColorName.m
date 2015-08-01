//
//  ColorName.m
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import "ColorName.h"

@implementation ColorName

+ (ColorName*)colorNameWithColor:(UIColor *)color name:(NSString *)name
{
    ColorName *cn = [[ColorName alloc] init];
    cn.color = color;
    cn.name = name;
    return cn;
}

@end

@implementation ColorName (Random)

+ (ColorName*)randomColorName
{
    static NSArray *choices = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        choices = @[
                    [ColorName colorNameWithColor:[UIColor blueColor] name:@"Room Temp"],
                    [ColorName colorNameWithColor:[UIColor redColor] name:@"More Ice"],
                    [ColorName colorNameWithColor:[UIColor greenColor] name:@"Concentrated"],
                    [ColorName colorNameWithColor:[UIColor yellowColor] name:@"White Grape Jelly"],
                    [ColorName colorNameWithColor:[UIColor orangeColor] name:@"Jap Sweet Potato Mochi"],
                    [ColorName colorNameWithColor:[UIColor purpleColor] name:@"Black Bean Matcha Jelly"],
                    [ColorName colorNameWithColor:[UIColor lightGrayColor] name:@"360cc"],
                    [ColorName colorNameWithColor:[UIColor colorWithHue:0 saturation:0.5 brightness:1 alpha:1.0] name:@"500cc"]
                    ];
    });
    
    NSInteger randIdx = arc4random() % choices.count;
    return choices[randIdx];
}
    
@end