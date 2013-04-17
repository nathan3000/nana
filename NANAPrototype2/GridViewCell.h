//
//  GridViewCell.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>  

#import "AQGridView.h"

@interface GridViewCell : AQGridViewCell

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) UILabel *captionLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)aReuseIdentifier scale:(float)scale;


@end
