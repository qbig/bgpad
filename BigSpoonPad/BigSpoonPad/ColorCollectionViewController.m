//
//  ColorCollectionViewController.m
//  CollectionViewItemAnimations
//
//  Created by Nick Donaldson on 8/27/13.
//  Copyright (c) 2013 nd. All rights reserved.
//

#import "ColorCollectionViewController.h"
#import "LessBoringFlowLayout.h"
#import "ModOptionCell.h"
#import "ColorSectionHeaderView.h"
#import "ColorSectionFooterView.h"
#import "UIColor+ColorFromHex.h"
#import "ModifierSection.h"
#import "ModifierOption.h"


@interface ColorCollectionViewController () <ColorSectionHeaderDelegate, ColorSectionFooterDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView * collectionView;


- (void)insertSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionAtIndex:(NSUInteger)index;

@end

@implementation ColorCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // This array will contain the ColorName objects that populate the CollectionView, one array per section
    // self.sectionModifiers = [NSMutableArray arrayWithObjects: [ModifierSection getDummyData] , nil];
    self.currentSelection = 0;
    // Allocate and configure the layout.
    LessBoringFlowLayout *layout = [[LessBoringFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f);
    
    // Bigger items for iPad
    layout.itemSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? CGSizeMake(120, 60) : CGSizeMake(80, 80);
    
    // uncomment this to see the default flow layout behavior
    //[layout makeBoring];
    
    
    // Allocate and configure a collection view
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;

    // Register reusable items
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ModOptionCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([ModOptionCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ColorSectionHeaderView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:NSStringFromClass([ColorSectionHeaderView class])];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ColorSectionFooterView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
            withReuseIdentifier:NSStringFromClass([ColorSectionFooterView class])];
    collectionView.backgroundColor = [UIColor clearColor];

    // Add to view
    [self.view addSubview:collectionView];
}

- (BOOL) isComplete {
    BOOL result = true;
    
    for (ModifierSection * sec in self.sectionModifiers) {
        if (sec.selectedOptionIndex == -1) {
            result = false;
            break;
        }
    }
    return result;
}

#pragma mark - Object insert/remove

- (void)insertSectionAtIndex:(NSUInteger)index
{
    //[self.sectionModifiers insertObject:[ModifierSection getDummyData] atIndex:index];
    
    // Batch this so the other sections will be updated on completion
    self.currentSelection++;
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:index]];
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
}

- (void)deleteSectionAtIndex:(NSUInteger)index
{
    // no checking if section exists - this is somewhat unsafe
    // [self.sectionModifiers removeObjectAtIndex:index];
    self.currentSelection--;
    // Batch this so the other sections will be updated on completion
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:index]];
    }
                                  completion:^(BOOL finished) {
                                      [self.collectionView reloadData];
                                  }];
    
}

#pragma mark - Header/Footer Delegates

- (void)colorSectionFooterAddSectionPressed:(ColorSectionFooterView *)footerView
{
    if (footerView.sectionIndex != NSNotFound)
    {
        [self insertSectionAtIndex:footerView.sectionIndex+1];
    }
}

- (void)colorSectionHeaderDeleteSectionPressed:(ColorSectionHeaderView *)headerView
{
    if (headerView.sectionIndex != NSNotFound)
    {
        [self deleteSectionAtIndex:headerView.sectionIndex];
    }
}

#pragma mark - UICollectionView Data Source

- (NSInteger) getSectionCount {
    return self.currentSelection >= self.sectionModifiers.count ? self.sectionModifiers.count : self.currentSelection + 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self getSectionCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ModifierSection *modSection = (ModifierSection *) self.sectionModifiers[section];
    return modSection.options.count;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * view = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        ColorSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:NSStringFromClass([ColorSectionHeaderView class])
                                                                                   forIndexPath:indexPath];
        header.sectionIndex = indexPath.section;
        //header.hideDelete = collectionView.numberOfSections == 1; // hide when only one section
        header.delegate = self;
        header.modSectionNameLabel.text = ((ModifierSection*)self.sectionModifiers[indexPath.section]).name;
        view = header;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        ColorSectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                            withReuseIdentifier:NSStringFromClass([ColorSectionFooterView class])
                                                                                   forIndexPath:indexPath];
        footer.sectionIndex = indexPath.section;
        footer.delegate = self;
        view = footer;
    }
    
    return view;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    NSArray *options = ((ModifierSection*) self.sectionModifiers[indexPath.section]).options;
    
    ModOptionCell *cnCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ModOptionCell class]) forIndexPath:indexPath];
    cnCell.optionModel = (ModifierOption*)options[indexPath.item];
    cell = cnCell;
    
    
    return cell;
}


#pragma mark - UICollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 25);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ModifierSection * selectedSection = self.sectionModifiers[indexPath.section];
    BOOL wasNotYetSelected = selectedSection.selectedOptionIndex == -1;
    ModifierOption * selectedOption = (ModifierOption*)selectedSection.options[indexPath.item];
    [selectedSection toggleOption:selectedOption];
    BOOL notSelectedAfterToggle = selectedSection.selectedOptionIndex == -1;
    if (wasNotYetSelected) {
        if (self.currentSelection < self.sectionModifiers.count-1) {
            [self insertSectionAtIndex:self.currentSelection+1];
        } else {
            [self.collectionView reloadData];
        }
    } else {
        if (notSelectedAfterToggle){
            for (int i = [self getSectionCount]-1; i > indexPath.section; i--) {
                [(ModifierSection*) [self.sectionModifiers objectAtIndex:i] unselect];
                [self deleteSectionAtIndex:i];
            }
        }
        [self.collectionView reloadData];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modifierSelectChange" object:self];
}


@end
