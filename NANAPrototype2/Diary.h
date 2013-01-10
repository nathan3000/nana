//
//  Diary.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 19/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Diary : NSManagedObject

@property (nonatomic, retain) NSString * label;

@end
