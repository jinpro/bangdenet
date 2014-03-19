//
//  Observer.h
//  bangdenet
//
//  Created by jin on 3/19/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Observer <NSObject>

-(void)update:(id)data;
@end
