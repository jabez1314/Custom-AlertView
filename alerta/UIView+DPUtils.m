//
//  UIView+DPUtils.m
//  cocacola
//
//  Created by Daniel Phillips on 22/04/2013.
//  Copyright (c) 2013 Pontomobi. All rights reserved.
//

#import "UIView+DPUtils.h"

@implementation UIView (DPUtils)

- (CGFloat)rightXPos
{
    return self.frame.origin.x + CGRectGetWidth(self.frame);
}

- (CGFloat)bottomYPos
{
    return self.frame.origin.y + CGRectGetHeight(self.frame);
}

@end
