//
//  AnwserCell.m
//  bangdenet
//
//  Created by jin on 2/22/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "AnwserCell.h"

@implementation AnwserCell

-(id)init{
    
    self=[[[NSBundle mainBundle] loadNibNamed:@"AnwserCell" owner:self options:nil] lastObject];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
