//
//  FilePath.h
//  bangdenet
//
//  Created by jin on 13-3-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePath : NSObject{
    
}

+(NSString*)getTaskPath;

+(NSString*)getSelPath;

+(NSString*)getMyPath;

+(NSString*)getFriPath;

+(NSString*)getFlagPath;

+(NSString*)getUserProfilePath;

+(NSString*)getMessageCountPath;

+(NSString*)getUserInfoPath;
+(BOOL)isPathExists:(NSString*)Path;
@end
