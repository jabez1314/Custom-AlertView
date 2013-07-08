//
//  AlertView.h
//  alerta
//
//  Created by Felipe Arimateia on 08/07/13.
//  Copyright (c) 2013 Felipe Arimateia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;

- (void)showInView:(UIView*)view;

@end

@protocol AlertViewDelegate
- (void)customAlertView:(AlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end