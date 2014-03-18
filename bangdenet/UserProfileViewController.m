//
//  UserProfileViewController.m
//  bangdenet
//
//  Created by jin on 3/12/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "UserProfileViewController.h"
#import "GenderSelectViewController.h"
#import "PreferenceViewController.h"
#import "JobStatusViewController.h"
#import "UIElements.h"
#import "MyUserInfo.h"
#import "MBProgressHUD.h"
#import "DateEditTextViewController.h"

@interface UserProfileViewController ()

@property(strong,nonatomic) NSMutableDictionary* ProfilesDictionary;

@property(strong,nonatomic) NSDictionary* OldProfilesDictionary;
@property(strong,nonatomic) NSDictionary* ShowTextMappingKey;
@property(copy,nonatomic) NSString* EditingType;
@property(strong,nonatomic) NSIndexPath* EditingIndexPath;

@end

@implementation UserProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //ui初始化
    self.navigationItem.title=@"个人信息";
    if (self.Editable) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(updateProfile:)];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithCGColor:[UIElements TintColor]];
    }
    
    //数据初始化
    self.ShowTextMappingKey=@{@"用户名：":@"u_name",@"我的座右铭：":@"motto",@"话题偏好：":@"preference",@"性别：":@"gender",@"联系电话：":@"u_tel",@"qq号：":@"qq_number",@"公司/单位：":@"company",@"职业状态：":@"job_status",@"出生日期：":@"birthdate"};
    
    if ([self.UserName isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"]]) {
        NSLog(@"自己的信息！\n");
        self.OldProfilesDictionary=[[MyUserInfo defaultMyUserInfo] requestDataWithBlocking];
        self.ProfilesDictionary=[NSMutableDictionary dictionaryWithDictionary:self.OldProfilesDictionary];
    }else{
        NSLog(@"%@的信息！\n",self.UserName);
        MBProgressHUD* HUB=[[MBProgressHUD alloc] initWithView:self.view];
        HUB.labelText=@"请稍等";
        HUB.dimBackground=YES;
        [self.view addSubview:HUB];
        [HUB showAnimated:YES whileExecutingBlock:^{
            NSLog(@"获得了信息\n");
            self.OldProfilesDictionary=[UserInfo UserProfileOfUserWithNameInBlocking:self.UserName];
        }completionBlock:^{
            self.ProfilesDictionary=[NSMutableDictionary dictionaryWithDictionary:self.OldProfilesDictionary];
            [self.tableview reloadData];
            NSLog(@"qq号码：%@\n",[self.ProfilesDictionary objectForKey:@"qq"]);
        }];
    }
    

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateProfile:(id)sender{
    
    MyUserInfo* MUIF=[MyUserInfo defaultMyUserInfo];
    MUIF.ProfileDictionary=self.ProfilesDictionary;
    [MUIF saveInBackground];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if(section==1){
        return 2;
    }else{
        return 6;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell* Cell=nil;
    if (indexPath.section==0) {
       Cell=[tableView dequeueReusableCellWithIdentifier:@"UnEditableProfileCell"];
        Cell.textLabel.text=@"用户名：";
        Cell.detailTextLabel.text=self.UserName;
        [self.ProfilesDictionary setValue:Cell.detailTextLabel.text forKey:@"u_name"];
    }else if (indexPath.section==1) {
        Cell=[tableView dequeueReusableCellWithIdentifier:@"EditableProfileCell"];
        
        switch (indexPath.row) {
            case 0:
                Cell.textLabel.text=@"我的座右铭：";
                
                break;
            case 1:
                Cell.textLabel.text=@"话题偏好：";
           
                break;
            default:
                break;
        }
  
        Cell.detailTextLabel.text=[self.ProfilesDictionary objectForKey:[self.ShowTextMappingKey objectForKey:Cell.textLabel.text]];
        NSLog(@"%@:%@",[self.ShowTextMappingKey objectForKey:Cell.textLabel.text],Cell.detailTextLabel.text);
    }else{
        Cell=[tableView dequeueReusableCellWithIdentifier:@"EditableProfileCell"];
       
        switch (indexPath.row) {
                case 0:
                Cell.textLabel.text=@"出生日期：";
                break;
            case 1:
                Cell.textLabel.text=@"性别：";
             
                break;
            case 2:
                Cell.textLabel.text=@"联系电话：";
              
                break;
            case 3:
                Cell.textLabel.text=@"qq号：";break;
               
            case 4:
                Cell.textLabel.text=@"公司/单位：";break;
               
            case 5:
                Cell.textLabel.text=@"职业状态：";break;
               
            default:
                break;
        }
        NSLog(@"用户信息数据：%@\n",self.ProfilesDictionary);
        Cell.detailTextLabel.text=[self.ProfilesDictionary objectForKey:[self.ShowTextMappingKey objectForKey:Cell.textLabel.text]];
        NSLog(@"%@:%@",[self.ShowTextMappingKey objectForKey:Cell.textLabel.text],Cell.detailTextLabel.text);
    }
    
    
    
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.Editable) {
        UIViewController* NextVC=[[GenderSelectViewController alloc] init];
        UITableViewCell* CellItem=[self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSString* CellItemText=CellItem.textLabel.text;
        if ([CellItemText isEqualToString:@"性别："]) {
            NextVC=[[GenderSelectViewController alloc] init];
        }else if ([CellItemText isEqualToString:@"话题偏好："]){
            NextVC=[[PreferenceViewController alloc] init];
        }else if([CellItemText isEqualToString:@"用户名："]){
            return ;
        }else if([CellItemText isEqualToString:@"出生日期："]){
            NextVC=[[DateEditTextViewController alloc] init];
        }else{
            
            NextVC=[[EditTextViewController alloc]init];
        }
        [NextVC setValue:[self.ShowTextMappingKey objectForKey:CellItemText] forKey:@"EditingType"];
        [NextVC setValue:CellItem.detailTextLabel.text forKey:@"TextString"];
        self.EditingType=[self.ShowTextMappingKey objectForKey:CellItemText];
        self.EditingIndexPath=indexPath;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateEditingInfo:) name:@"UpdateInfo" object:nil];
        
        [self.navigationController pushViewController:NextVC animated:YES];
    }
    
     
}



-(void)updateEditingInfo:(NSNotification*)notification{
    
    
    [self.ProfilesDictionary setValue:[notification object] forKey:self.EditingType];
    [self.tableview reloadRowsAtIndexPaths:@[self.EditingIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UpdateInfo" object:nil];
}

@end
