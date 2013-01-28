//
//  ViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "MealPickerViewController.h"

#import "CoreDataTableViewController.h"

#import "Diary.h"

#import "AQGridView.h"

#import "GridViewCell.h"

@interface MainViewController : CoreDataTableViewController <MealPickerDelegate, FoodTreeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, AQGridViewDelegate, AQGridViewDataSource> {
    MealPickerViewController *_mealPicker;
    UIPopoverController *_mealPickerPopover;
}

@property (nonatomic, retain) MealPickerViewController *mealPicker;

@property (nonatomic, retain) FoodTreeViewController *foodTreeViewController;

@property (nonatomic, retain) UINavigationController *foodTreeModal;

@property (nonatomic, retain) UIPopoverController *mealPickerPopover;

@property (strong, nonatomic) IBOutlet UITableView *diaryTableView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIView *favouritesView;

@property (strong, nonatomic) AQGridView *favouritesGridView;

@property (nonatomic, retain) NSMutableArray *favouriteItems;

- (IBAction)addItem:(id)sender;

@end
