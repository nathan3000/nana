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

@interface FoodTreeViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource, ItemViewControllerDelegate> {
    Tree *tree;
}

@property (strong, nonatomic) IBOutlet UILabel *labelMenuName;

@property (weak) id delegate;

@property (nonatomic, retain) IBOutlet AQGridView *gridView;

@property (nonatomic, retain) NSArray *items;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end




