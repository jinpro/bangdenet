//
//  ResListViewController.m
//  bangdenet
//
//  Created by jin on 13-3-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "ResListViewController.h"
#import "Request.h"
#import "FilePath.h"
#import "DetailsShowViewController.h"
#import "QuestionCell.h"
#import "AnwserCell.h"
#import "UIElements.h"
#import "CustomActionSheet.h"
@interface ResListViewController ()

@end

@implementation ResListViewController{
    NSArray* ResArray;
    int CurrentIndex;
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
  
    [self downLoadData];
    
}

-(void)downLoadData{
    
    dispatch_queue_t download_t=dispatch_queue_create("download_t", NULL);
    dispatch_async(download_t, ^{
        NSArray* data=[[NSArray alloc] initWithContentsOfFile:[FilePath getTaskPath]
                       ];
        NSString* strSel=[[NSString alloc] initWithContentsOfFile:[FilePath getSelPath] encoding:NSUTF8StringEncoding error:nil];
        NSDictionary* dict=[data objectAtIndex:[strSel intValue]];
        Request* req=[[Request alloc] init];
        [req setFile:@"/task/get_task_response.php"];
        [req add:[dict objectForKey:@"t_number"] forkey:@"t_number"];
        ResArray=[req getList];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        return [ResArray count];
    }
    
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"问题";
    }
    else{
        return @"回答";
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        QuestionCell* cell=[[QuestionCell alloc] init];
        
        cell.ContentLabel.text=[self.QuestionDictionary objectForKey:@"t_text"];
        cell.PublisherName.text=[self.QuestionDictionary objectForKey:@"u_name"];
        cell.TimeLabel.text=[self.QuestionDictionary objectForKey:@"time"];
        cell.DistanceLabel.text=@"";
        return cell;
    }else{
        AnwserCell* cell=[[AnwserCell alloc] init];
    
        NSDictionary* dict=[ResArray objectAtIndex:indexPath.row];
        cell.AnwserContentLabel.text=[dict objectForKey:@"h_text"];
        cell.PublisherLabel.text=[dict objectForKey:@"u_name"];
        cell.TimeLabel.text=[dict objectForKey:@"time"];
        
        return cell;

        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* Cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return Cell.frame.size.height;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CurrentIndex=indexPath.row;
    if (indexPath.section==1) {
        NSLog(@"选择了答案！\n");
        self.TransitionContent=[[ResArray objectAtIndex:indexPath.row] objectForKey:@"h_text"];
    }
    if (indexPath.section==0) {
        NSLog(@"选择了问题！");
        self.TransitionContent=[self.QuestionDictionary objectForKey:@"t_text"];
    }
    
    if ([self.FunctionFlag isEqualToString:@"NewFriend"]) {
        UIActionSheet* ActionSheet=[[CustomActionSheet alloc] initWithTitle:@"选项" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"查看详情",@"给TA留言",@"关闭",nil];
        ActionSheet.tintColor=[UIColor colorWithCGColor:[UIElements TintColor]];
        [ActionSheet showFromTabBar:self.tabBarController.tabBar];
        return ;
    }
    [self performSegueWithIdentifier:@"ModalDetailsView" sender:self];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ModalDetailsView"]) {
        
        [segue.destinationViewController setValue:self.TransitionContent forKey:@"ShowText"];
    }
    if ([segue.identifier isEqualToString:@"FromAnwserToMessage"]) {
        [segue.destinationViewController setValue:[[ResArray objectAtIndex:CurrentIndex] objectForKey:@"u_name"] forKey:@"HostUserName"];
    }
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==-1) {
        
    }else if (buttonIndex==0){
        
        [self performSegueWithIdentifier:@"ModalDetailsView" sender:self];
        
    }else if (buttonIndex==1){
        [self performSegueWithIdentifier:@"FromAnwserToMessage" sender:self];
    }else{
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
    }
    
}



-(void)viewWillAppear:(BOOL)animated{
    if ([self.tableview indexPathForSelectedRow]!=nil) {
        [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
    }
    
}



@end
