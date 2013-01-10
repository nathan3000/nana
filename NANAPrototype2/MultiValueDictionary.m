//
//  MultiValueDictionary.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 13/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "MultiValueDictionary.h"

/**
 Utility function for creating a new NSMutableSet containing object; if object is a set or array, the set containts all objects in the collection.
 */
static inline NSMutableSet* createMutableSetFromObject(id object) {
	if (object == nil)
		return nil;   
	if ([object isKindOfClass:[NSSet class]])
		return [NSMutableSet setWithSet:object];
	if ([object isKindOfClass:[NSArray class]])
		return [NSMutableSet setWithArray:object];
	else
		return [NSMutableSet setWithObject:object];
}

@implementation MultiValueDictionary

- (id)init
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }  
    
    return self;
}

- (id)objectsForKey:(id)aKey
{
    return [_dictionary objectForKey:aKey];
}

- (void)setObject:(id)anArray forKey:(id)aKey {
    //NSSet *objectSet = createMutableSetFromObject(anObject);
    //NSArray *objectArray = [[NSArray alloc] initWithArray:anArray];
    [_dictionary setObject:anArray forKey:aKey];
}

- (void)addObject:(id)anObject forKey:(id)aKey
{
    // Check key doesn't already exist first
    NSMutableArray *objects = [self objectsForKey:aKey];
    if (objects == nil) {
        objects = [[NSMutableArray alloc] init];
    }
    [objects addObject:anObject];
    [self setObject:objects forKey:aKey];
}

@end
