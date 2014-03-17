//
//  LeaveMessageViewController.m
//  bangdenet
//
//  Created by jin on 2/21/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "LeaveMessageViewController.h"
#import "Request.h"
#import "NotificatingUserMethods.h"
@interface LeaveMessageViewController ()

@end

@implementation LeaveMessageViewController

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
    UIBarButtonItem* BackItem=[[UIBarButtonItem alloc] init];
    
    self.navigationItem.backBarButtonItem=BackItem;
    BackItem.title=@"返回";
    [self.MessageText becomeFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LeaveMessage:(id)sender {
    
    if ([self.MessageText.text isEqualToString:@""]) {
        [NotificatingUserMethods showMessageInStatusBar:@"没有留言内容"];
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    }
    Request* req=[[Request alloc] init];
    
    [req setFile:@"/board/publish_board.php"];
    
    NSUserDefaults* Settings=[NSUserDefaults standardUserDefaults];
    
    [req add:self.HostUserName forkey:@"host"];
    [req add:[Settings objectForKey:@"u_name"] forkey:@"guest"];
    [req add:self.MessageText.text forkey:@"text"];
    NSString* result=[req submit];
    NSLog(@"%@",result);
    if ([result isEqualToString:@"ok"]) {
        
        [NotificatingUserMethods showMessageInStatusBar:@"留言成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
