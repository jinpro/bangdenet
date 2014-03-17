//
//  MyResViewController.m
//  bangdenet
//
//  Created by jin on 13-3-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "MyResViewController.h"
#import "FilePath.h"
#import "Request.h"
#import "AnwserCell.h"
@interface MyResViewController ()

@end

@implementation MyResViewController{
    NSArray* MyResArray;
    
    int CurrentIndex;
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
    
    [self downLoadData];

}


-(void)downLoadData{
    
    dispatch_queue_t refresh_t=dispatch_queue_create("refresh_answer_t",NULL);
    
    dispatch_async(refresh_t, ^{
        NSArray* data=[[NSArray alloc] initWithContentsOfFile:[FilePath getMyPath]
                       ];
        NSString* strSel=[[NSString alloc] initWithContentsOfFile:[FilePath getSelPath] encoding:NSUTF8StringEncoding error:nil];
        NSDictionary* dict=[data objectAtIndex:[strSel intValue]];
        Request* req=[[Request alloc] init];
        [req setFile:@"/task/get_task_response.php"];
        [req add:[dict objectForKey:@"t_number"] forkey:@"t_number"];
        MyResArray=[req getList];
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
    
    return [MyResArray count];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnwserCell* Cell=[[AnwserCell alloc] init];
    
    NSDictionary* dict=[MyResArray objectAtIndex:indexPath.row];
    Cell.AnwserContentLabel.text=[dict objectForKey:@"h_text"];
    
    Cell.PublisherLabel.text=[dict objectForKey:@"u_name"];
    Cell.TimeLabel.text=[dict objectForKey:@"time"];
    
    
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CurrentIndexPath=indexPath;
    UIActionSheet* ActionSheet=[[UIActionSheet alloc] initWithTitle:@"选项" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"查看详情",@"给TA留言", nil];
    [ActionSheet showInView:self.view];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* Cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return  Cell.frame.size.height;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        
    }else if (buttonIndex==1){
        AnwserCell* Cell=(AnwserCell*)[self tableView:self.tableview cellForRowAtIndexPath:CurrentIndexPath];
        self.TransitionContent=Cell.AnwserContentLabel.text;
        NSLog(@"查看详情！\n");
        [self performSegueWithIdentifier:@"PushDetailsRes" sender:self];
        
        
    }else if(buttonIndex==2){
        NSLog(@"给TA留言！\n");
        [self performSegueWithIdentifier:@"HelpToResponseMessage" sender:self];
        
    }else{
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"PushDetailsRes"]) {
        if (CurrentIndexPath.section==1) {
           [segue.destinationViewController setValue:self.TransitionContent forKey:@"ShowText"];
        }
        if (CurrentIndexPath.section==0) {
           
            [segue.destinationViewController setValue:self.TransitionContent forKey:@"ShowText"];
        }
        
    }
    
    if ([segue.identifier isEqualToString:@"HelpToResponseMessage"]) {
        [segue.destinationViewController setValue:[[MyResArray objectAtIndex:CurrentIndex] objectForKey:@"u_name"] forKey:@"HostUserName"];
    }
}
@end
