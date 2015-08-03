//
//  ModifierSection.m
//  BigSpoonPad
//
//  Created by Qiao Liang on 1/8/15.
//  Copyright (c) 2015 Qiao Liang. All rights reserved.
//

#import "ModifierSection.h"

@implementation ModifierSection

+ (ModifierSection*) sectionWithDict: (NSDictionary*) dict {
    ModifierSection * modSec = [[ModifierSection alloc] init];
    modSec.name = dict[@"name"];
    modSec.modifierDescription = dict[@"description"];
    NSMutableArray *options = [[NSMutableArray alloc] init];
    for (NSDictionary * pair in dict[@"options"]) {
        [options addObject: [ModifierOption optionWithPrice:[pair[@"price"] floatValue]  name:pair[@"name"]]];
    }
    modSec.options = options;
    modSec.selectedOptionIndex = -1;
    return modSec;
}

- (void) toggleOption: (ModifierOption*) toggledOption {
    toggledOption.selected = !toggledOption.selected;
    if (toggledOption.selected) {
        for (int i = 0; i < self.options.count; i++){
            ModifierOption* op = (ModifierOption*)self.options[i];
            if (![op.name isEqualToString: toggledOption.name]) {
                op.selected = false;
            } else {
                self.selectedOptionIndex = i;
            }
        }
    } else {
        self.selectedOptionIndex = -1;
    }
}

- (void) unselect {
    self.selectedOptionIndex = -1;
    for (int i = 0; i < self.options.count; i++){
        ModifierOption* op = (ModifierOption*)self.options[i];
        op.selected = false;
    }
}

@end


@implementation ModifierSection (DummyData)

+ (ModifierSection*) getDummyData {
    static NSArray *choices = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        choices = @[
                    @{@"name" : @"Temperature",
                      @"options": @[@{@"name":@"More Ice", @"price": @0},
                                    @{@"name":@"Iced", @"price": @0},
                                    @{@"name":@"Less Ice", @"price": @0},
                                    @{@"name":@"No Ice", @"price": @0},
                                    @{@"name":@"Room Temp", @"price": @0},
                                    @{@"name":@"Warm", @"price": @0},
                                    @{@"name":@"Hot", @"price": @0}]
                      },
                    @{@"name" : @"Size",
                      @"options": @[@{@"name":@"360cc", @"price": @0},
                                    @{@"name":@"500cc", @"price": @0}]
                      },
                    @{@"name" : @"Sweetness",
                      @"options": @[@{@"name":@"Skinny", @"price": @0},
                                    @{@"name":@"Mild", @"price": @0},
                                    @{@"name":@"Balanced", @"price": @0},
                                    @{@"name":@"Concentrated", @"price": @0}]
                      },
                    @{@"name" : @"Toppings/Texture",
                      @"options": @[@{@"name":@"White Grape Jelly", @"price": @0},
                                    @{@"name":@"Jap Sweet Potato Mochi", @"price": @0},
                                    @{@"name":@"Black Bean Matcha Jelly", @"price": @0},
                                    ]
                      }
                    ];
    });
    
    NSInteger randIdx = arc4random() % choices.count;
    return [ModifierSection sectionWithDict: choices[randIdx]];
}

@end

