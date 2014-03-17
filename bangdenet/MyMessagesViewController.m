//
//  MyMessagesViewController.m
//  bangdenet
//
//  Created by jin on 2/21/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "MyMessagesViewController.h"
#import "AnwserCell.h"
#import "Request.h"
#import "FilePath.h"
#import "UIElements.h"
#import "CustomActionSheet.h"
@interface MyMessagesViewController ()


@end

@implementation MyMessagesViewController{
    
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
    [self downloadData];
    [self listenNewMessage];
}

-(void)downloadData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        Request* req=[[Request alloc] init];
        [req setFile:@"/board/get_my_board.php"];
        [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.MessagesArray=[req getList];
            [self.tableview reloadData];
        });
        
    });
    
    
}

-(void)listenNewMessage{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            Request* req=[[Request alloc] init];
            [req setFile:@"/board/get_my_board.php"];
            [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
            NSArray* NewArray=[req getList];
            if (NewArray==nil) {
                break;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([NewArray count]>[self.MessagesArray count]) {
                    self.MessagesArray=NewArray;
                }
                [self.tableview reloadData];
            });
            sleep(5);
        }
    });

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.MessagesArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnwserCell* Cell=[[AnwserCell alloc]init];
    

    Cell.AnwserContentLabel.text=[[self.MessagesArray objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    Cell.PublisherLabel.text=[[self.MessagesArray objectAtIndex:indexPath.row] objectForKey:@"guest"];
    Cell.TimeLabel.text=[[self.MessagesArray objectAtIndex:indexPath.row] objectForKey:@"time"];
 
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* Cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return Cell.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CurrentIndex=indexPath.row;
    UIActionSheet* ActionSheet=[[CustomActionSheet alloc] initWithTitle:@"选项" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"查看详细信息",@"给TA留言",@"关闭",nil];
    
    ActionSheet.tintColor=[UIColor colorWithCGColor:[UIElements TintColor]];
    [ActionSheet showFromTabBar:self.tabBarController.tabBar];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==-1) {
        
    }else if (buttonIndex==0){
        
        [self performSegueWithIdentifier:@"ShowDetailsMessage" sender:self];
    }else if (buttonIndex==1){
        [self performSegueWithIdentifier:@"ResponseMessage" sender:self];
        
    }else if(buttonIndex==2){
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"ShowDetailsMessage"]) {
        [segue.destinationViewController setValue:[[self.MessagesArray objectAtIndex:CurrentIndex] objectForKey:@"text"] forKey:@"ShowText"];
    }
    
    if ([segue.identifier isEqualToString:@"ResponseMessage"]) {
        
        [segue.destinationViewController setValue:[[self.MessagesArray objectAtIndex:CurrentIndex] objectForKey:@"guest"] forKey:@"HostUserName"];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        Request* req=[[Request alloc] init];
        [req setFile:@"/board/delete_message.php"];
        
        [req add:[[self.MessagesArray objectAtIndex:indexPath.row] objectForKey:@"m_id"] forkey:@"m_id"];
        NSString* result=[req submit];
        
        if ([result isEqualToString:@"yes"]) {
            [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self downloadData];
            [tableView reloadData];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableview deselectRowAtIndexPath:[self.tableview indexPathForSelectedRow] animated:YES];
}





@end
