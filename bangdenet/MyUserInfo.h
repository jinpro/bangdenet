//
//  MyUserInfo.h
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "UserInfo.h"
#import "DataModel.h"
@interface MyUserInfo : UserInfo<DataModel>

@property(strong,nonatomic)NSDictionary* ProfileDictionary;
-(void)saveInBackground;
-(NSDictionary*)requestDataWithBlocking;
+(id)defaultMyUserInfo;
@end
