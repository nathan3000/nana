//
//  ViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "CoreDataTableViewController.h"

#import "DiaryEntry.h"

#import "AQGridView.h"

#import "GridViewCell.h"

#import "FoodTreeViewController.h"

#import "SettingsViewController.h"

#import "ModalViewController.h"

#import "Helpers.h"

#import "DiaryItem.h"

#import "Meal.h"

@protocol MealDiaryControllerDelegate <NSObject>

- (void)finishedMeal;

- (void)back;

@end

@interface MainViewController : CoreDataTableViewController <UITableViewDelegate, UITableViewDataSource, AQGridViewDelegate, AQGridViewDataSource, FoodTreeViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
}

@property (nonatomic, retain) FoodTreeViewController *foodTreeViewController;

@property (nonatomic, retain) UINavigationController *foodTreeModal;
@property (strong, nonatomic) IBOutlet UIView *diaryTopBorder;

@property (nonatomic, retain) UIPopoverController *mealPickerPopover;

@property (strong, nonatomic) IBOutlet UITableView *diaryTableView;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIView *favouritesView;

@property (strong, nonatomic) AQGridView *favouritesGridView;

@property (nonatomic, retain) NSMutableArray *favouriteItems;

@property (nonatomic, strong) NSString *selectedMeal;

@property (strong, nonatomic) IBOutlet UIView *diaryView;

@property (strong, nonatomic) UILabel *diaryTitleLabel;

@property (strong, nonatomic) NSDictionary *finishedMeals;

@property (strong, nonatomic) UIButton *foodTreeButton;

@property (strong, nonatomic) IBOutlet UIButton *finishedButton;

@property (strong, nonatomic) IBOutlet UILabel *mealTitle;

@property (strong, nonatomic) IBOutlet UIButton *changeMealButton;

@property (strong, nonatomic) NSString *color;

@property (weak) id delegate;

@end
