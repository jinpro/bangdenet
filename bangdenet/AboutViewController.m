//
//  AboutViewController.m
//  bangdenet
//
//  Created by jin on 13-3-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AboutViewController.h"
#import "FilePath.h"
#import "Request.h"
#import "MLPAccessoryBadge.h"
#import "UIColor+MLPFlatColors.h"
#import <QuartzCore/QuartzCore.h>
#import "NotificatingUserMethods.h"
#import "UserProfileViewController.h"
#import "UIElements.h"
@interface AboutViewController ()

@end

@implementation AboutViewController{
    
    NSArray* MessagesArray;
    NSIndexPath* MessageIndexPath;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithCGColor:[UIElements TintColor]]];
    MessageIndexPath=nil;
    
    Request* req=[[Request alloc] init];
    
    [req setFile:@"/board/get_my_board.php"];
    [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
    
    MessagesArray=[req getList];
    dispatch_queue_t new_message_t=dispatch_queue_create("newmessage", NULL);
    dispatch_async(new_message_t, ^{
        while (1) {
            [req setFile:@"/board/get_my_board.php"];
            [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
            NSArray* NewArray=[req getList];
            
            if ([NewArray count]!=[MessagesArray count]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    MessagesArray=NewArray;
                    if (MessageIndexPath!=nil) {
                        [self.tableview reloadRowsAtIndexPaths:@[MessageIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    
                });
                
            }
            sleep(5);

        }
        
    });
     
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        return 2;
    }else {
        return 2;
    }

    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        if (indexPath.row==0) {
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"showcell"];
            NSUserDefaults* Settings=[NSUserDefaults standardUserDefaults];
            self.UserName=[Settings objectForKey:@"u_name"];
            cell.textLabel.text=[ NSString stringWithFormat:@"用户名：%@",self.UserName ];
            return cell;
            
        }
        if (indexPath.row==1) {
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"setcell"];
            MessageIndexPath=indexPath;
            NSString* DisplayString=[NSString stringWithFormat:@"留言板(%d)",[MessagesArray count]];
     
           cell.textLabel.text=DisplayString;
            return cell;
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"setcell"];
            cell.textLabel.text=@"我的意见";
            return cell;
            
        }else if(indexPath.row==1){
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"setcell"];
            cell.textLabel.text=@"关于我们";
            return cell;
            
        }
        
    }
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"setcell"];
    cell.textLabel.text=@"设置";
    return cell;
}


- (IBAction)logout:(id)sender {
    
    NSFileManager* FileManager=[NSFileManager defaultManager];
    [FileManager removeItemAtPath:[FilePath getUserProfilePath] error:nil];
    
    [self performSegueWithIdentifier:@"Reset" sender:self];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     self.hidesBottomBarWhenPushed = YES;
    if (indexPath.section==1) {
        
        if (indexPath.row==0) {
            [self performSegueWithIdentifier:@"PushFeedBack" sender:self];
        }
        if (indexPath.row==1) {
            [self performSegueWithIdentifier:@"PushAboutDevelopers" sender:self];
        }
    }
    
    if (indexPath.section==0) {
        
        if (indexPath.row==1) {
            if ([MessagesArray count]>0) {
                [self performSegueWithIdentifier:@"PushMyMessages" sender:self];
                
            }else{
                
                UIAlertView* view=[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有留言" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [view show];
            }
            
        }
        
        if (indexPath.row==0) {
            UIStoryboard* UPStoryboard=[UIStoryboard storyboardWithName:@"UserProfile" bundle:[NSBundle mainBundle]];
            UserProfileViewController* UPVC=[UPStoryboard instantiateInitialViewController];
            UPVC.Editable=YES;
            UPVC.UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"];
           
            [self.navigationController pushViewController:UPVC animated:YES];
            
       
        }
    }
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([segue.identifier isEqualToString:@"PushMyMessages"]) {
        [segue.destinationViewController setValue:MessagesArray forKey:@"MessagesArray"];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}


@end
