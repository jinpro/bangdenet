//
//  FriClassViewController.m
//  bangdenet
//
//  Created by jin on 1/22/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "FriClassViewController.h"

@interface FriClassViewController ()

@end

@implementation FriClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* Cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];    return Cell.frame.size.height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"FriClassItem"];
    if(indexPath.row==0)
        cell.textLabel.text=@"帮助过我的人";
    else if(indexPath.row==1)
        cell.textLabel.text=@"我帮助过的人";
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
     if(indexPath.row==0){
     didSelectedRow=0;
     [self performSegueWithIdentifier:@"PushMyFriend" sender:self];
     
     }else if(indexPath.row==1){
     didSelectedRow=1;
     [self performSegueWithIdentifier:@"PushMyFriend" sender:self];
     }
     
     
   
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if (didSelectedRow==0) {
        [segue.destinationViewController setValue:@"HelpingMe" forKey:@"FriendClass"];
    }else if(didSelectedRow==1){
        [segue.destinationViewController setValue:@"HelpedByMe" forKey:@"FriendClass"];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

 
@end
