//
//  Helpers.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 27/02/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

#import "DiaryItem.h"

#import "DiaryEntry.h"

#import "Meal.h"

#import "ModalViewController.h"

#import "ItemViewController.h"

#import "FoodTreeItem.h"

@interface Helpers : NSObject

+ (void)addItemToDiary:(Item *)selectedItem forMeal:(NSString *)selectedMeal withContext:(NSManagedObjectContext *)managedObjectContext;

+ (void)removeSubviewFrom:(UIView *)parent withTag:(NSInteger)aTag;

+ (void)selectItem:(FoodTreeItem *)item forMeal:(NSString *)meal withController:(UIViewController *)controller andContext:(NSManagedObjectContext *)managedObjectContext;
@end
