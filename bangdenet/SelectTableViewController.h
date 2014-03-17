//
//  SelectTableViewController.h
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) UITableView* tableview;
@property(copy,nonatomic) NSString* EditingType;
@property(copy,nonatomic) NSString* TextString;
@property(strong,nonatomic) NSArray* DisplayArray;
@end
