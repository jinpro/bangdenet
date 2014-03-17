//
//  TabViewController.m
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TabViewController.h"
#import "FilePath.h"
#import "Request.h"
#import "UIElements.h"
@interface TabViewController ()

@end

@implementation TabViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString* str=@"1";
    self.tabBar.tintColor=[UIColor colorWithCGColor:[UIElements TintColor]];
    [str writeToFile:[FilePath getFlagPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
