//
//  AboutDevelopersViewController.m
//  bangdenet
//
//  Created by jin on 1/25/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "AboutDevelopersViewController.h"

@interface AboutDevelopersViewController ()

@end

@implementation AboutDevelopersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.AboutLabel.text=@"";
    self.AboutLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"biglogo.png"]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
