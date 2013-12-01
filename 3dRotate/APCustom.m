//
//  APCustom.m
//  3dRotate
//
//  Created by alberto pasca on 02/07/13.
//  Copyright (c) 2013 Alberto Pasca. All rights reserved.
//

#import "APCustom.h"
#import <QuartzCore/QuartzCore.h>


@implementation APCustom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass
{
  return [CATransformLayer class];
}

@end
