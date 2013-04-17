//
//  DiaryEntry.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 09/03/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DiaryItem, Meal;

@interface DiaryEntry : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) DiaryItem *item;
@property (nonatomic, retain) Meal *meal;

@end
