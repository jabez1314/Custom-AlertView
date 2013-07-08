//
//  AlertView.m
//  alerta
//
//  Created by Felipe Arimateia on 08/07/13.
//  Copyright (c) 2013 Felipe Arimateia. All rights reserved.
//

#import "AlertView.h"
#import "UILabel+dynamicSizeMe.h"
#import "UIView+DPUtils.h"
#import <QuartzCore/QuartzCore.h>

#define HEIGHT_MESSAGE_IPHONE 252.0

@interface AlertView ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *otherButtonTitles;
@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblMessage;
@property (nonatomic, strong) UIButton *btCancelButtonTitle;
@property (nonatomic, strong) UIButton *btOtherButtonTitles;

@end

@implementation AlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles
{
    CGRect frame;
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeRight)
        frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    else
        frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.alpha = 0.95;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.title = title;
        self.message = message;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitles = otherButtonTitles;
        
        [self createAlert];
    }
    return self;
}


- (void)createAlert {
    
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat alertHeight = 227.0;
    CGFloat alertWidth = 274.0;
    
    if (self.title) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 254.0, 21.0)];
        [self.lblTitle setBackgroundColor:[UIColor clearColor]];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setText:self.title];
        y = [self.lblTitle bottomYPos] + 20;
    }
    else {
        alertHeight -= 41.0;
    }
    
    if (self.message) {
        
        self.lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 254.0, 100.0)];
        [self.lblMessage setBackgroundColor:[UIColor clearColor]];
        [self.lblMessage setTextAlignment:NSTextAlignmentCenter];
        [self.lblMessage setTextColor:[UIColor whiteColor]];
        [self.lblMessage setText:self.message];
       
        
        CGFloat height = [self.lblMessage expectedHeight];
        
        height = (height > HEIGHT_MESSAGE_IPHONE) ? HEIGHT_MESSAGE_IPHONE : height;
        
        if (height > 100.0) {
            alertHeight += (height - 100);
        }
        else {
            alertHeight -= (100 - height);
        }
        
        CGRect frame = self.lblMessage.frame;
        frame.size.height = height;
        [self.lblMessage setFrame:frame];
        
        y = [self.lblMessage bottomYPos] + 26;
    }
    else {
        alertHeight -= 126.0;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, alertWidth, 1.0)];
    [line setBackgroundColor:[UIColor whiteColor]];
    y = [line bottomYPos] + 5;
    
    
    if (self.cancelButtonTitle && self.otherButtonTitles) {
        
        self.btCancelButtonTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btCancelButtonTitle setFrame:CGRectMake(8.0, y, 125, 39)];
        [self.btCancelButtonTitle setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [self.btCancelButtonTitle setBackgroundColor:[UIColor blackColor]];
        [self.btCancelButtonTitle.layer setCornerRadius:5.0];
        [self.btCancelButtonTitle.layer setMasksToBounds:YES];
        [self setTag:1000];
        
        self.btOtherButtonTitles = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btOtherButtonTitles setFrame:CGRectMake([self.btCancelButtonTitle rightXPos] + 8, y, 125, 39)];
        [self.btOtherButtonTitles setTitle:self.otherButtonTitles forState:UIControlStateNormal];
        [self.btOtherButtonTitles setBackgroundColor:[UIColor blackColor]];
        [self.btOtherButtonTitles.layer setCornerRadius:5.0];
        [self.btOtherButtonTitles.layer setMasksToBounds:YES];
        [self setTag:1001];
    }
    else if (self.otherButtonTitles) {
        
        self.btOtherButtonTitles = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btOtherButtonTitles setFrame:CGRectMake(8, y, 258, 39)];
        [self.btOtherButtonTitles setTitle:self.otherButtonTitles forState:UIControlStateNormal];
        [self.btOtherButtonTitles setBackgroundColor:[UIColor blackColor]];
        [self.btOtherButtonTitles.layer setCornerRadius:5.0];
        [self.btOtherButtonTitles.layer setMasksToBounds:YES];
        [self setTag:1001];
    }
    else {
        
        NSString *btTitle = (self.cancelButtonTitle) ? self.cancelButtonTitle : @"OK";
        
        self.btCancelButtonTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btCancelButtonTitle setFrame:CGRectMake(8.0, y, 258, 39)];
        [self.btCancelButtonTitle setTitle:btTitle forState:UIControlStateNormal];
        [self.btCancelButtonTitle setBackgroundColor:[UIColor blackColor]];
        [self.btCancelButtonTitle.layer setCornerRadius:5.0];
        [self.btCancelButtonTitle.layer setMasksToBounds:YES];
        [self setTag:1000];
    }

    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake((int)((self.frame.size.width-alertWidth)/2.0), (int)((self.frame.size.height-alertHeight)/2.0), alertWidth, alertHeight)];
   self.alertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.alertView setBackgroundColor:[UIColor redColor]];
    
    [self.alertView.layer setCornerRadius:10.0];
    [self.alertView.layer setMasksToBounds:YES];
    
    [self addSubview:self.alertView];
    
    [self.alertView addSubview:line];
    
    
    if (self.lblTitle) {
        [self.alertView addSubview:self.lblTitle];
    }
    
    if (self.lblMessage) {
         [self.alertView addSubview:self.lblMessage];
    }
    
    if (self.btCancelButtonTitle) {
        [self.btCancelButtonTitle addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.btCancelButtonTitle];
    }
    
    if (self.btOtherButtonTitles) {
        [self.btOtherButtonTitles addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.btOtherButtonTitles];
    }
    
    
}

- (void)onBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int button_index = button.tag-1000;
    
    if ([self.delegate respondsToSelector:@selector(customAlertView:clickedButtonAtIndex:)])
        [self.delegate customAlertView:self clickedButtonAtIndex:button_index];
    
    [self animateHide];
}

- (void)showInView:(UIView*)view
{
    if ([view isKindOfClass:[UIView class]])
    {
        [view addSubview:self];
        [self animateShow];
    }
}

- (void)animateShow
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.2;
    
    [self.alertView.layer addAnimation:animation forKey:@"show"];
}

- (void)animateHide
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.0, 0.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.1;
    
    [self.alertView.layer addAnimation:animation forKey:@"hide"];
    
    [self performSelector:@selector(removeFromSuperview) withObject:self afterDelay:0.105];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
