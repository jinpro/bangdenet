//
//  ResponseViewController.m
//  bangdenet
//
//  Created by jin on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ResponseViewController.h"
#import "FilePath.h"
#import "Request.h"
#import "NotificatingUserMethods.h"
@interface ResponseViewController ()

@end

@implementation ResponseViewController

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
	
    self.title=@"回答问题";
    [self.ResponseText becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Response:(id)sender {
    
   NSArray* data=[[NSArray alloc] initWithContentsOfFile:[FilePath getTaskPath]];
    
    NSString* strSel=[[NSString alloc] initWithContentsOfFile:[FilePath getSelPath] encoding:NSUTF8StringEncoding error:nil];
    
 
    NSDictionary* dict=[data objectAtIndex:[strSel intValue]];
    t_number=[dict objectForKey:@"t_number" ];
    
    
    
    if (self.ResponseText.text.length<=0) {
        [NotificatingUserMethods showMessageInStatusBar:@"没有回答问题"];
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }
    if (self.ResponseText.text.length>200) {
        [NotificatingUserMethods showMessageInStatusBar:@"一次回答字数不能超过200字"];
        return ;
    }
    HUB=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUB];
    
    HUB.dimBackground=YES;
  
    [HUB showAnimated:YES whileExecutingBlock:^{
        Request* req=[[Request alloc] init];
        [req setFile:@"/task/task_response.php"];
        [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"u_name"];
            NSLog(@"name:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"]);
            
        [req add:t_number forkey:@"t_number"];
        
        [req add:self.ResponseText.text forkey:@"text"];
            
        result=[req submit];
        
    } completionBlock:^{
        if([result isEqualToString:@"ok"])
        {
            [NotificatingUserMethods showMessageInStatusBar:@"回答成功"];
            [self.navigationController popViewControllerAnimated:YES];
            //[self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            UIAlertView* view=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
        }
    }];
    
}

@end
