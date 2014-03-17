//
//  MyViewController.h
//  bangdenet
//
//  Created by jin on 13-3-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    MBProgressHUD* HUB;
}


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong,nonatomic) NSArray* QuestionsArray;
@property(strong,nonatomic) NSIndexPath* CurrentIndexPath;
@end
