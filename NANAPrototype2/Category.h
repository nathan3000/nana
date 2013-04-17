//
//  Category.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 08/03/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Category : NSManagedObject

@property (nonatomic, retain) NSNumber * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parent;

@end
