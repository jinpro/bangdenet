//
//  SearchViewController.h
//  bangdenet
//
//  Created by jin on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>{
    CLLocationManager* TheManager;
    CLLocation* location;
    int count;
    NSString* flagStr;
    MBProgressHUD* HUB;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;



@end
