//
//  MyViewController.m
//  bangdenet
//
//  Created by jin on 13-3-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MyViewController.h"
#import "Request.h"
#import "FilePath.h"
#import "QuestionCell.h"
#import "TextViewController.h"
#import "NotificatingUserMethods.h"
#import "UIElements.h"
@interface MyViewController ()

@end

@implementation MyViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableview.tintColor=[UIColor colorWithCGColor:[UIElements TintColor]];
    static int AccessCount=0;
    AccessCount++;
    if (AccessCount==1) {
        NSLog(@"第一次访问\n");
        [self DownLoadData];
        [self listenToNewAnswer];
    }else{
        NSLog(@"第n次访问\n");
        [self DownLoadData];
    }
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(AddQuestion:) name:@"AddQuestion" object:nil];
    
}


-(void)AddQuestion:(NSNotification*)notification{
    [self DownLoadData];
}

-(void)DownLoadData{
   
    self.QuestionsArray=[[NSMutableArray alloc] init];
    dispatch_queue_t download_queue_t=dispatch_queue_create("download_t", NULL);
    dispatch_async(download_queue_t, ^{
        Request* req=[[Request alloc] init];
        [req setFile:@"/task/get_my_task.php"];
        
        [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.QuestionsArray=[req getList];
            [self.tableview reloadData];
            
        });
                       
    });
    
    
}

-(void)listenToNewAnswer{
    
    dispatch_async(dispatch_queue_create("download_t", NULL), ^{
        while (1) {
            Request* req=[[Request alloc] init];
            [req setFile:@"/task/get_my_task.php"];
            
            [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
            NSArray* NewArray=[req getList];
            if ([NewArray count]==0) {
                [NotificatingUserMethods showMessageInAlertView:@"网络已经断开，无法获得网络数据"];
                break;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.QuestionsArray=[req getList];
                [self.tableview reloadData];
                
            });
            
            sleep(5);

        }
        
    });
    

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.QuestionsArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        NSDictionary* dict=[self.QuestionsArray objectAtIndex:indexPath.row];
    QuestionCell* cell=[[QuestionCell alloc]init];
    NSString* ContentString=[NSString stringWithFormat:@"%@(%@)",[dict objectForKey:@"t_text"],[dict objectForKey:@"count"]];
    
    cell.ContentLabel.text=ContentString;
    cell.ClassLabel.text=[dict objectForKey:@"t_title"];
    cell.TimeLabel.text=[dict objectForKey:@"time"];
    cell.NumberofResponseLabel.text=@"";
    cell.PublisherName.text=@"";
    cell.DistanceLabel.text=@"";
        return cell;

  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
    self.CurrentIndexPath=indexPath;
    NSString* row=[NSString stringWithFormat:@"%d",indexPath.row];
    NSString* Path=[FilePath getSelPath];
    NSString* myPath=[FilePath getTaskPath];
    [row writeToFile:Path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [self.QuestionsArray writeToFile:myPath atomically:YES];
    [self performSegueWithIdentifier:@"MyRes" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"MyRes"]) {
        [segue.destinationViewController setValue:[self.QuestionsArray objectAtIndex:self.CurrentIndexPath.row] forKey:@"QuestionDictionary"];
        [segue.destinationViewController setValue:@"NewFriend" forKey:@"FunctionFlag"];
    }
    
    if ([segue.identifier isEqualToString:@"AddQuestion"]) {
        
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle==UITableViewCellEditingStyleDelete){
        NSDictionary* UserDict=[self.QuestionsArray objectAtIndex:indexPath.row];
        Request* req=[[Request alloc] init];
        [req setFile:@"/task/delete_task.php"];
        [req add:[UserDict objectForKey:@"t_number"] forkey:@"t_number"];
        NSString* result=[req submit];
        if ([result isEqualToString:@"yes"]) {
            [self DownLoadData];
            
        }
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* Cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return Cell.frame.size.height;
    
}
- (IBAction)addQuestion:(id)sender {
    
    if (self.navigationController!=nil) {
        NSLog(@"有导航视图类！");
        TextViewController* TextVC=[[TextViewController alloc] init];
        [self.navigationController pushViewController:TextVC animated:YES];
    }else{
        NSLog(@"没有导航视图类！");
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

@end
