//
//  ResListViewController.h
//  bangdenet
//
//  Created by jin on 13-3-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ResListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    MBProgressHUD* HUB;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (copy,nonatomic) NSString* TransitionContent;
@property (copy,nonatomic) NSDictionary* QuestionDictionary;

@property(copy,nonatomic) NSString* FunctionFlag;
@end
