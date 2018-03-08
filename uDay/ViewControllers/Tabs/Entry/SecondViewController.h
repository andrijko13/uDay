//
//  SecondViewController.h
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Styler.h"
#import  "UITextField+Placeholders.h"
#import "CustomizeViewController.h"

@interface SecondViewController : UIViewController <UITextFieldDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (weak, nonatomic) IBOutlet UITextField *dateView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)clearTapped:(id)sender;
- (IBAction)controlChanges:(id)sender;
@property NSDictionary *context;
@end

