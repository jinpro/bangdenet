//
//  DetailsShowViewController.m
//  bangdenet
//
//  Created by jin on 1/25/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "DetailsShowViewController.h"

@interface DetailsShowViewController ()

@end

@implementation DetailsShowViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.DetailsLabel.text=self.ShowText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
