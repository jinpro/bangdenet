//
//  MessageData.h
//  bangdenet
//
//  Created by jin on 3/19/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observer.h"
#import "Subject.h"
@interface MessageData : NSObject<Subject>


-(void)registerObserver:(id<Observer>)NewObserver;
-(void)removeObserver:(id<Observer>)PresentObserver;
-(void)notifyObservers;

+(id)getInstance;

-(void)run;
@end
