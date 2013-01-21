//
//  MealPickerViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 15/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FoodTreeViewController.h"

@protocol MealPickerDelegate <NSObject>


@end

@interface MealPickerViewController : UIViewController {
    id<MealPickerDelegate> _delegate;
}

@property (nonatomic, strong) id<MealPickerDelegate> delegate;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSString *selectedMeal;

@end
