//
//  MealSelectionViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 23/02/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "MealDiaryViewController.h"

@interface MealSelectionViewController : UIViewController <MealDiaryControllerDelegate> {
    MealDiaryViewController *diaryController;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIButton *breakfastButton;
@property (strong, nonatomic) IBOutlet UIButton *lunchButton;
@property (strong, nonatomic) IBOutlet UIButton *dinnerButton;
@property (strong, nonatomic) IBOutlet UIView *buttonBlock;
@property (strong, nonatomic) IBOutlet UIButton *snacksButton;
@end
