//
//  CheckViewController.m
//  bangdenet
//
//  Created by jin on 13-3-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CheckViewController.h"
#import "Request.h"
@interface CheckViewController ()

@end

@implementation CheckViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)check:(id)sender {
    
    NSString* CheckCode=[Request getInfo:@"check"];
    
    if([self.CheckText.text isEqualToString:CheckCode])
    {
        
        UIAlertView* view=[[UIAlertView alloc] initWithTitle:@"提示" message:@"验证成功，可以登陆！" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        
        [view show];
        [self performSegueWithIdentifier:@"backMain" sender:self];
        
    }
}

@end
