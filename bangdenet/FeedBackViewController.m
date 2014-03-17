//
//  FeedBackViewController.m
//  bangdenet
//
//  Created by jin on 1/25/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "FeedBackViewController.h"
#import "Request.h"
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

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
    [self.FeedBackText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(id)sender {
    BOOL IsSubmited=NO;
    
    if (self.FeedBackText.text.length<10) {
        UIAlertView* view=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的反馈信息太短，请输入至少十个字！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil ];
        [view show];
        return ;
        
    }
    Request* req=[[Request alloc] init];
    [req setFile:@"/feedback.php"];
    [req add:self.FeedBackText.text forkey:@"feedback_text"];
    NSString* result=[req submit];
    NSString* msg=nil;
    if ([result isEqualToString:@"yes"]) {
        msg=@"提交成功";
        IsSubmited=YES;
    }else if ([result isEqualToString:@"no"]){
        msg=@"提交失败，请再次提交！";
    }
    
    UIAlertView* view=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil ];
    [view show];
    if (IsSubmited) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
}

@end
