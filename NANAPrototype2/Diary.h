//
//  Diary.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/01/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Diary : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * meal;

@end
