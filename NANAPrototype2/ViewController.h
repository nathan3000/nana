//
//  ViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MealPickerViewController.h"

@interface ViewController : UIViewController <MealPickerDelegate, FoodTreeViewControllerDelegate> {
    MealPickerViewController *_mealPicker;
    UIPopoverController *_mealPickerPopover;
}

@property (nonatomic, retain) MealPickerViewController *mealPicker;

@property (nonatomic, retain) UIPopoverController *mealPickerPopover;

- (IBAction)addItem:(id)sender;

@end
