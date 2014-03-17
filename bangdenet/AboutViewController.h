//
//  AboutViewController.h
//  bangdenet
//
//  Created by jin on 13-3-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property(strong,nonatomic) NSString* UserName;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(copy,nonatomic) NSString* isNewMessage;
@end
