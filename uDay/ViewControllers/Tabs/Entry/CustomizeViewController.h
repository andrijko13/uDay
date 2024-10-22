//
//  CustomizeViewController.h
//  uDay
//
//  Created by Andriko on 2/3/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Styler.h"
#import "CustomizeCollectionViewCell.h"
#import "UIImage+Insets.h"
#import "Entry.h"
#import "DataStore.h"
#import "AddToMapViewController.h"

@class SecondViewController;

@interface CustomizeViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, AddLocationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addToMapButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property Entry *context;
@property (weak, nonatomic) SecondViewController *par;
- (IBAction)addToMapClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;
@end
