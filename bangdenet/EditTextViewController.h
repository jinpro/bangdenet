//
//  EditTextViewController.h
//  bangdenet
//
//  Created by jin on 3/12/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTextViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (copy,nonatomic) NSString* TextString;
@property (copy,nonatomic) NSString* EditingType;
-(id)initWithString:(NSString*)TextString;
-(void)finishEdit:(id)sender;
@end
