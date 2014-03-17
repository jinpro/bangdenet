//
//  FriViewController.m
//  bangdenet
//
//  Created by jin on 13-3-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FriViewController.h"
#import "Request.h"
#import "FilePath.h"
#import "CustomActionSheet.h"
@interface FriViewController ()

@end

@implementation FriViewController{
    NSArray* FriList;
    NSIndexPath* CurrentIndexPath;
}

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
    
    if ([self.FriendClass isEqual:@"HelpingMe"]) {
        
        self.navigationItem.title=@"帮助过我的人";
    }else if([self.FriendClass isEqualToString:@"HelpedByMe"]){
        
        self.navigationItem.title=@"我帮助过的人";
    }
    [self downLoadData];
}

-(void)downLoadData{
    
    dispatch_queue_t download_t=dispatch_queue_create("download_t", NULL);
    dispatch_async(download_t, ^{
        Request* req=[[Request alloc] init];
        
        [req setFile:@"/friend/get_friend.php"];
        
        [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
        [req add:self.FriendClass forkey:@"FriendClass"];
        FriList=[req getList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [FriList count];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"FriItem"];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriItem"];
    }
    
    NSDictionary* dict=[FriList objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[dict objectForKey:@"u_name"];
    cell.detailTextLabel.text=[dict objectForKey:@"u_tel"];
     
    return cell;
     
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentIndexPath=indexPath;
    UIActionSheet* ActionSheet=[[CustomActionSheet alloc] initWithTitle:@"选项" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"查看TA的问题",@"给TA留言",@"关闭",nil];
    
    [ActionSheet showFromTabBar:self.tabBarController.tabBar];
    
    
    
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==-1) {
        [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
    }else if(buttonIndex==0){
        
        NSString* strRow=[NSString stringWithFormat:@"%d",CurrentIndexPath.row];
        NSString* SelPath=[FilePath getSelPath];
        
        NSString* FriPath=[FilePath getFriPath];
        
        
        NSString* flagStr=@"fri";
        [flagStr writeToFile:[FilePath getFlagPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [strRow writeToFile:SelPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [FriList writeToFile:FriPath atomically:YES ];
        [self performSegueWithIdentifier:@"PushFriendQuestions" sender:self];
        
    }else if(buttonIndex==1){
        
        [self performSegueWithIdentifier:@"LeaveMessage" sender:self];
    }else if(buttonIndex==2){
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"文本改变");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([segue.identifier isEqualToString:@"LeaveMessage"]) {
        
        [segue.destinationViewController setValue:[[FriList objectAtIndex:CurrentIndexPath.row]objectForKey:@"u_name"] forKey:@"HostUserName"];
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
}
@end
