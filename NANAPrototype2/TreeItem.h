//
//  TreeItem.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeItem : NSObject

@property (nonatomic, copy) NSString *caption;

@property (nonatomic, retain) UIImage *image;

- (id)initWithCaption:(NSString *)theCaption andImage:(UIImage *)theImage;

@end
