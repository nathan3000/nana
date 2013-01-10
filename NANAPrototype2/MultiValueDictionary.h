//
//  MultiValueDictionary.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 13/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiValueDictionary : NSObject {
    NSMutableDictionary *_dictionary;
}

- (void)addObject:(id)anObject forKey:(id)aKey;

- (id)objectsForKey:(id)aKey;

@end
