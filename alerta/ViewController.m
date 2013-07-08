//
//  ViewController.m
//  alerta
//
//  Created by Felipe Arimateia on 08/07/13.
//  Copyright (c) 2013 Felipe Arimateia. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AlertView *alert = [[AlertView alloc] initWithTitle:@"Title" message:@"Customize the look." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alert showInView:self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
