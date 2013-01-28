//
//  ContentViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AQGridView.h"

#import "GridViewCell.h"

#import "Tree.h"

#import "ItemViewController.h"

@protocol FoodTreeViewControllerDelegate <NSObject>

- (void)dismissMainPopover;

@end

@interface FoodTreeViewController : CoreDataTableViewController <AQGridViewDelegate, AQGridViewDataSource, ItemViewControllerDelegate> {
    Tree *tree;
    bool loadFavourites;
}

@property (strong, nonatomic) IBOutlet UILabel *labelMenuName;

@property (nonatomic, strong) NSString *selectedMeal;

@property (weak) id delegate;

@property (nonatomic, retain) IBOutlet UIView *foodTreeContainerView;

@property (nonatomic, retain) IBOutlet AQGridView *foodTreeGridView;

@property (nonatomic, retain) NSArray *foodTreeItems;

@property (nonatomic, strong) ItemViewController *itemViewController;

@property (nonatomic, strong) UINavigationController *itemViewPopover;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end




