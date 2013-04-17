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

#import "Item.h"

#import "Helpers.h"

@protocol ItemViewControllerDelegate <NSObject>

- (void)dismissItemModal;

@end

@interface ItemViewController : UIViewController

@property (weak) id delegate;

@property (strong, nonatomic) NSString *selectedMeal;

@property (strong, nonatomic) Item *selectedItem;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UILabel *stepperValueLabel;

@end
