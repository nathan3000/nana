//
//  DiaryItem.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 09/03/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Item.h"

@class DiaryEntry;

@interface DiaryItem : Item

@property (nonatomic, retain) id options;
@property (nonatomic, retain) NSSet *diaryEntry;
@end

@interface DiaryItem (CoreDataGeneratedAccessors)

- (void)addDiaryEntryObject:(DiaryEntry *)value;
- (void)removeDiaryEntryObject:(DiaryEntry *)value;
- (void)addDiaryEntry:(NSSet *)values;
- (void)removeDiaryEntry:(NSSet *)values;

@end
