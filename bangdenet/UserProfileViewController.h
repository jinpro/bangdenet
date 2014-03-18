//
//  UserProfileViewController.h
//  bangdenet
//
//  Created by jin on 3/12/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property(assign,nonatomic) BOOL Editable;
@property(copy,nonatomic) NSString* UserName;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
