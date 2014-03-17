//
//  DataModel.h
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataModel <NSObject>
@required
-(BOOL)updateToService;

-(BOOL)saveInBackground;

@optional
-(void)downLoadFromService;
-(BOOL)backupToNative;
-(void)loadFromNative;
-(NSDictionary*)requestDataWithBlocking;
@end
