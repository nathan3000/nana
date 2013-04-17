//
//  Helpers.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 27/02/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

+ (void)addItemToDiary:(DiaryItem *)selectedItem forMeal:(NSString *)selectedMeal withContext:(NSManagedObjectContext *)managedObjectContext
{    
    Meal *meal = [NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:managedObjectContext];
    meal.type = selectedMeal;
    meal.startTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"mealStartTime"];
    
    DiaryItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryItem" inManagedObjectContext:managedObjectContext];
    item.name = selectedItem.name;
    item.image = selectedItem.image;
    item.options = selectedItem.options;
    
    DiaryEntry *diary = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryEntry" inManagedObjectContext:managedObjectContext];
    diary.time = [NSDate date];
    diary.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    [meal setValue:diary forKey:@"diaryEntry"];
    [diary setValue:meal forKey:@"meal"];
    [diary setValue:item forKey:@"item"];
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    /*
    NSLog(@"Adding %@ to food diary for %@", selectedItem.caption, selectedMeal);
    
    Diary *diary = [NSEntityDescription insertNewObjectForEntityForName:@"Diary"
                                                 inManagedObjectContext:managedObjectContext];
    
    diary.label = selectedItem.caption;
    
    diary.meal = selectedMeal;
    
    diary.time = [NSDate date];
    
    diary.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSLog(@"mealStartTime:%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"mealStartTime"]);
    
    diary.mealStartTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"mealStartTime"];
    
    [managedObjectContext save:nil]; // write to database
     */
}

+ (void)removeSubviewFrom:(UIView *)parent withTag:(NSInteger)aTag {
    for (UIView *subView in parent.subviews) {
        [self removeSubviewFrom:subView withTag:aTag];
        if (subView.tag == aTag) {
            [subView removeFromSuperview];
        }
    }
}

+ (void)selectItem:(FoodTreeItem *)item forMeal:(NSString *)meal withController:(UIViewController *)controller andContext:(NSManagedObjectContext *)managedObjectContext {
    if ([item.options boolValue] == NO) {
        [self addItemToDiary:item forMeal:meal withContext:managedObjectContext];
    } else {
        
        ItemViewController *itemViewController = [[ItemViewController alloc] init];
        
        itemViewController.delegate = controller;
        
        itemViewController.managedObjectContext = managedObjectContext;
        
        itemViewController.selectedItem = item;
        
        itemViewController.selectedMeal = meal;
        
        [self presentModalViewController:itemViewController andSize:CGSizeMake(500, 500) andModalTransitionStyle:UIModalTransitionStyleCoverVertical from:controller];
    }
}

+ (UIViewController *)presentModalViewController:(UIViewController *)viewController
                                         andSize:(CGSize)size
                         andModalTransitionStyle:(UIModalTransitionStyle)modalTransitionStyle
                                            from:(UIViewController *)parentController
{
    viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    viewController.modalTransitionStyle = modalTransitionStyle;
    [parentController presentViewController:viewController animated:YES completion:nil];
    viewController.view.superview.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    viewController.view.superview.frame = CGRectMake(0, 0, size.width, size.height);
    CGPoint center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    viewController.view.superview.center = UIDeviceOrientationIsPortrait(parentController.interfaceOrientation) ? center : CGPointMake(center.y, center.x);
    
    return viewController;
}

@end
