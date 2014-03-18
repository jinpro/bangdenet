//
//  UserInfo.h
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(copy,nonatomic) NSString* u_name;
@property(copy,nonatomic) NSString* motto;
@property(copy,nonatomic) NSString* preference;
@property(copy,nonatomic) NSString* gender;
@property(copy,nonatomic) NSString* u_tel;
@property(copy,nonatomic) NSString* qq_number;
@property(copy,nonatomic) NSString* job_status;
@property(copy,nonatomic) NSString* company;
@property(copy,nonatomic) NSString* birthdate;
@property(strong,nonatomic)NSDictionary* ProfileDictionary;
-(void)TransfromPropertysToDictionary;
+(NSDictionary*)UserProfileOfUserWithNameInBlocking:(NSString*)UserName;
@end
