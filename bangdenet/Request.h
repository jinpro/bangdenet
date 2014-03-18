//
//  Request.h
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject{
    
    NSMutableString* strURL;
    NSMutableString* body;
    NSURL* url;
    NSMutableURLRequest* request;
    
}

@property(weak,nonatomic) NSData* result;
-(id)init;

-(void)add:(NSString*)value forkey:(NSString*)key;
-(NSString*)submit;

-(void)setFile:(NSString*)FileName;
+(NSString*)getInfo:(NSString*)property;

-(NSMutableArray*)getList;
-(NSDictionary*)dictionaryOfJSON;
-(void)setArguments:(NSDictionary*)ArgumentsDictionary;
@end
