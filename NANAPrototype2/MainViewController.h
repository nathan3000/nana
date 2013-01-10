//
//  ViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MealPickerViewController.h"

#import "CoreDataTableViewController.h"

#import "Diary.h"

@interface MainViewController : CoreDataTableViewController <MealPickerDelegate, FoodTreeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    MealPickerViewController *_mealPicker;
    UIPopoverController *_mealPickerPopover;
}

@property (nonatomic, retain) MealPickerViewController *mealPicker;

@property (nonatomic, retain) UIPopoverController *mealPickerPopover;

@property (strong, nonatomic) IBOutlet UITableView *diaryTableView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)addItem:(id)sender;

@end
