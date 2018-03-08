//
//  SecondViewController.m
//  uDay
//
//  Created by Andriko on 12/2/17.
//  Copyright © 2017 Andriko. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    NSDate *selectedDate;
}
@end

@implementation SecondViewController
@synthesize titleView;
@synthesize dateView;
@synthesize textView;
@synthesize doneButton;
@synthesize context;
@synthesize segmentedControl;

- (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];
    [doneButton setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [self.titleView setBackgroundColor:[[Styler main] colorForKey:EditableBackgroundGray]];
    [self.dateView setBackgroundColor:[[Styler main] colorForKey:EditableBackgroundGray]];
    [self.textView setBackgroundColor:[[Styler main] colorForKey:EditableBackgroundGray]];
    [self.segmentedControl setBackgroundColor:[[Styler main] colorForKey:EditableBackgroundGray]];
    [self.titleView setPlaceholderColor:LightGray withText:@"Title"];
    [self.dateView  setPlaceholderColor:LightGray withText:@"Date"];

    [self.titleView setTextColor:[[Styler main] colorForKey:White]];
    [self.dateView setTextColor:[[Styler main] colorForKey:White]];

    [self.titleView setDelegate:self];
    [self.dateView setDelegate:self];

    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateView setInputView:datePicker];

    [self.textView setTextColor:[[Styler  main] colorForKey:White]];

    [self.textView.layer setCornerRadius:5.0f];
    [self.doneButton.layer setCornerRadius:5.0f];

    [self.textView setAutocorrectionType:UITextAutocorrectionTypeNo];

    [doneButton.titleLabel setText:@"Continue"];
    [doneButton setTitleColor:[[Styler main] colorForKey:White] forState:UIControlStateNormal];

    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(doneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.textView.inputAccessoryView = keyboardToolbar;
    self.dateView.inputAccessoryView = keyboardToolbar;

    [self setPlaceholders: true];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateView.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:picker.date];
    self.dateView.text = [NSString stringWithFormat:@"%@",formattedDate];

    selectedDate = picker.date;
}
-(void)doneButtonPressed {
    [self.textView resignFirstResponder];
    [self.dateView resignFirstResponder];
}

- (void)viewDidLoad {
    [self style];
    self.context = nil;
    

    [super viewDidLoad];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

//-(void)viewWillAppear:(BOOL)animated {
//    if (context != nil) {
//        NSString *title = [context valueForKey:@"title"];
//        NSString *date = [context valueForKey:@"date"];
//        NSString *text = [context valueForKey:@"text"];
//
//        if (title != nil) {
//            [self.titleView setText:title];
//        }
//        if (date != nil) {
//            [self.dateView setText:date];
//        }
//        if (text != nil) {
//            [self.textView setText:text];
//        }
//    } else {
//        [self.titleView setText:@""];
//        [self.dateView setText:@""];
//        [self.textView setText:@""];
//    }
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearTapped:(id)sender {
    [self.titleView setText:@""];
    [self.dateView setText:@""];
    [self setPlaceholders:true];
}

-(void)setPlaceholders: (BOOL)withForce {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self.segmentedControl setTintColor:[[Styler main] colorForKey:LightOrange]];
        [self.doneButton setBackgroundColor:[[Styler main] colorForKey:LightOrange]];
        [self.dateView  setPlaceholderColor:LightGray withText:@"Goal Date"];
        if ([textView.text isEqualToString:@"Today, I..."] || withForce) {
            [textView setText:@"I want to..."];
        }
    } else {
        [self.segmentedControl setTintColor:[[Styler main] colorForKey:LightBlue]];
        [self.doneButton setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
        [self.dateView  setPlaceholderColor:LightGray withText:@"Date"];
        if ([textView.text isEqualToString:@"I want to..."] || withForce) {
            [textView setText:@"Today, I..."];
        }
    }

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"nextClicked"] && [segue destinationViewController].class == [CustomizeViewController class]) {
        CustomizeViewController *vc = [segue destinationViewController];
        Entry *e = [Entry new];

        e.title = titleView.text;
        e.setDate = selectedDate;
        e.description = textView.text;
        e.isGoal = !segmentedControl.selectedSegmentIndex;
        e.complete = false;

        vc.context = e;
    }
}

- (IBAction)controlChanges:(id)sender {
    [UIView animateWithDuration:0.5f animations:^{
        [self setPlaceholders:false];
    }];
}
@end
