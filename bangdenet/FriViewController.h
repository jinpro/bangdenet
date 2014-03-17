//
//  FriViewController.h
//  bangdenet
//
//  Created by jin on 13-3-11.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface FriViewController : UIViewController<UITableViewDataSource,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UIActionSheetDelegate>{
    MBProgressHUD* HUB;
    NSArray* SearchResult;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSString* FriendClass;
@end
