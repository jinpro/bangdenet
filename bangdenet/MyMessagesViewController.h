//
//  MyMessagesViewController.h
//  bangdenet
//
//  Created by jin on 2/21/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessagesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(strong,nonatomic) NSArray* MessagesArray;
@property(strong,nonatomic) NSMutableArray* EditableMessagesArray;
@end
