//
//  CustomActionSheet.m
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "CustomActionSheet.h"
#import "UIElements.h"
@implementation CustomActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showFromTabBar:(UITabBar *)view{
    
    for (UIView* SubView in self.subviews) {
        
        if ([SubView isKindOfClass:[UIButton class]]) {
            UIButton* button=(UIButton*)SubView;
            [button setTitleColor:[UIColor colorWithCGColor:[UIElements TintColor]] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithCGColor:[UIElements TintColor]] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor colorWithCGColor:[UIElements TintColor]] forState:UIControlStateHighlighted];
        }
    }
    
    [super showFromTabBar:view];
}

@end
