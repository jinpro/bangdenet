//
//  Subject.h
//  bangdenet
//
//  Created by jin on 3/19/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Observer.h"
@protocol Subject <NSObject>
@required
-(void)registerObserver:(id<Observer>)NewObserver;
-(void)removeObserver:(id<Observer>)PresentObserver;
-(void)notifyObservers;
@end
