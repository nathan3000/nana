//
//  ItemViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 19/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "CoreDataTableViewController.h"

#import "DiaryEntry.h"

#import "FoodTreeItem.h"

#import "Helpers.h"

#import "AQGridView.h"

#import "GridViewCell.h"

@protocol ItemViewControllerDelegate <NSObject>

- (void)dismissItemModal;

@end

@interface ItemViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>

@property (weak) id delegate;

@property (strong, nonatomic) NSString *selectedMeal;

@property (strong, nonatomic) FoodTreeItem *selectedItem;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UILabel *stepperValueLabel;

@property (strong, nonatomic) AQGridView *gridView;

@property (strong, nonatomic) NSMutableDictionary *options;

@property (strong, nonatomic) NSArray *preselects;

@property (strong, nonatomic) NSMutableDictionary *selectedOptions;

@end
