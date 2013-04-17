//
//  Meal.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 09/03/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DiaryEntry;

@interface Meal : NSManagedObject

@property (nonatomic, retain) NSDate * finishTime;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) DiaryEntry *diaryEntry;

@end
