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

#import "FoodTreeItem.h"

#import "ItemViewController.h"

@protocol FoodTreeViewControllerDelegate <NSObject>

- (void)dismissMainPopover;

@end

@interface FoodTreeViewController : CoreDataTableViewController <AQGridViewDelegate, AQGridViewDataSource, ItemViewControllerDelegate> {
    bool loadFavourites;
}

@property (strong, nonatomic) IBOutlet UILabel *labelMenuName;

@property (nonatomic, strong) NSString *selectedMeal;

@property (weak) id delegate;

@property (nonatomic, retain) IBOutlet UIView *foodTreeContainerView;

@property (nonatomic, retain) IBOutlet AQGridView *foodTreeGridView;

@property (nonatomic, strong) ItemViewController *itemViewController;

@property (nonatomic, strong) UINavigationController *itemViewPopover;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) FoodTreeItem *selectedItem;

@end




