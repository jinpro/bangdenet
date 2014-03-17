//
//  MyResViewController.h
//  bangdenet
//
//  Created by jin on 13-3-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface MyResViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    MBProgressHUD* HUB;
    NSString* result;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(copy,nonatomic) NSString* TransitionContent;

@end
