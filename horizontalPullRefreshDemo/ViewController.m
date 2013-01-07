//
//  ViewController.m
//  horizontalPullRefreshDemo
//
//  Created by Chu Mohua on 13-1-7.
//  Copyright (c) 2013年 Chu Mohua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block id blockself = self;
    [scrollview setContentSize:CGSizeMake(scrollview.bounds.size.width+1, scrollview.bounds.size.height)];
    [scrollview addHPullRefresh:^{
        [blockself performSelector:@selector(stopRefresh:) withObject:nil afterDelay:3.0];
    }];
    
    [scrollview startLoading];
}

-(void)stopRefresh:(id)sender{
    [scrollview stopLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
