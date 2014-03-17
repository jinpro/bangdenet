//
//  RegisterViewController.m
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "Request.h"
#import "NotificatingUserMethods.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    self.PwdText.secureTextEntry=YES;
    self.RePwdText.secureTextEntry=YES;
    self.TelVision.on=YES;
    userFlag=@"1";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SubmitAction:(id)sender {
    
    int flag=0;
    NSString* msg=@"";
    if([self.UserNameText.text isEqualToString:@""])
    {
        flag=0;
        msg=@"请输入用户名！";
        
    }
    else
    {
        if([self.PwdText.text isEqualToString:@""])
        {
            msg=@"请输入密码！";
        }
        else
        {
            if([self.RePwdText.text isEqualToString:@""])
            {
                msg=@"请再次输入密码！";
            }
            else
            {
                if([self.RePwdText.text isEqualToString:self.PwdText.text])
                {
                    flag=1;
                }
                else
                {
                    msg=@"两次输入密码不一致！";
                }
            }
        }
    }
    
    if(!flag)
    {
        UIAlertView* view=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil ];
        [view show];
        return ;
    }
    Request* req=[[Request alloc] init];
    
    [req setFile:@"/user/user_register.php"];
    
    [req add:self.UserNameText.text forkey:@"u_name"];
    [req add:self.TelNumberText.text forkey:@"u_tel"];
    [req add:self.PwdText.text forkey:@"u_pwd"];
    
        [req add:userFlag forkey:@"flag"];
    
    NSString* str=[req submit];
    
    NSString* result=[[str substringToIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@",result);
    
    
    if([result isEqualToString:@"ok"])
    {
        msg=@"注册成功！";
        UIAlertView* view=[[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil ];
        [view show];
        [self performSegueWithIdentifier:@"backhome" sender:self];
        
    }
    else if([result isEqualToString:@"no"])
    {
        [NotificatingUserMethods showMessageInAlertView:@"注册失败，您的用户名已经被占用"];
    }else{
        [NotificatingUserMethods showMessageInAlertView:@"无法连接网络"];
    }
   
    
}
- (IBAction)TextEnd:(id)sender {
    
    [self.UserNameText resignFirstResponder];
    [self.PwdText resignFirstResponder];
    [self.TelNumberText resignFirstResponder];
    [self.RePwdText resignFirstResponder];
}

- (IBAction)CheckAction:(id)sender {

}
- (IBAction)switchChange:(id)sender {
    
    UISwitch* Fswitch=(UISwitch*)sender;
    if(Fswitch.isOn){
        userFlag=@"1";
    }else{
        userFlag=@"0";
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.UserNameText resignFirstResponder];
    [self.PwdText resignFirstResponder];
    [self.TelNumberText resignFirstResponder];
    [self.RePwdText resignFirstResponder];
}

@end
