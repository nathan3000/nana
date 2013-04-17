//
//  Diary.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 08/03/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item, Meal, User;

@interface Diary : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) Item *item;
@property (nonatomic, retain) Meal *meal;
@property (nonatomic, retain) User *user;

@end
