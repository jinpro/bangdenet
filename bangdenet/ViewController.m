//
//  ViewController.m
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TabViewController.h"
#import "Request.h"
#import "RegisterViewController.h"
#import "FilePath.h"
#import "NotificatingUserMethods.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.PwdText.secureTextEntry=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    
    NSString*  msg=@"请输入用户名！";
    int flag=0;
    if(self.TelNumberText.text.length==0)
    {
        flag=0;
    }
    else
    {
        if(self.PwdText.text.length==0)
        {
            flag=0;
            msg=@"请输入密码！";
        }
        else
        {
            flag=1;
        }
    }
    if(flag==0)
    {
    UIAlertView* view=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        return ;
    }
    
    HUB=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.dimBackground=YES;
    
    HUB.labelText=@"请稍后";
    
    [HUB showAnimated:YES whileExecutingBlock:^{
        Request* req=[[Request alloc] init];
        [req setFile:@"/user/login.php"];
        [req add:self.TelNumberText.text forkey:@"u_name"];
        [req add:self.PwdText.text forkey:@"u_pwd"];
        result=[NSString stringWithString:[req submit]];
    
    } completionBlock:^{
        [HUB removeFromSuperview];
        HUB=nil;
        if([result isEqualToString:@"ok"])
        {
            NSUserDefaults* Setting=[NSUserDefaults standardUserDefaults];
            [ Setting setObject:self.TelNumberText.text forKey:@"u_name"];
            [ Setting setObject:self.PwdText.text forKey:@"u_pwd"];
            
            NSMutableDictionary* UserProfileDict=[[NSMutableDictionary alloc] init];
            
            [UserProfileDict setValue:self.TelNumberText.text forKey:@"u_name"];
            [UserProfileDict setValue:self.PwdText.text forKey:@"u_pwd"];
            
            [UserProfileDict writeToFile:[FilePath getUserProfilePath] atomically:NO];
            
            NSLog(@"登陆成功！");
            
            
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }
        else if([result isEqualToString:@"no"])
        {
            [NotificatingUserMethods showMessageInAlertView:@"登录失败，帐号或者密码错误，请重新输入"];
        }else{
            
            [NotificatingUserMethods showMessageInAlertView:@"网络没有连接"];
            return ;
        }
        
    
    }];
      
        
}
- (IBAction)TextEnd:(id)sender {
    [self.TelNumberText resignFirstResponder];
    [self.PwdText resignFirstResponder];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.TelNumberText resignFirstResponder];
    [self.PwdText resignFirstResponder];
}



@end
