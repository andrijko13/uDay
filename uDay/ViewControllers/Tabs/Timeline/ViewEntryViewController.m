//
//  ViewEntryViewController.m
//  uDay
//
//  Created by Andriko on 4/11/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "ViewEntryViewController.h"

@interface ViewEntryViewController ()
{
    double cellWidth;
}

@end

@implementation ViewEntryViewController
@synthesize context;
@synthesize imagesCollectionView;
@synthesize textView;
@synthesize scrollView;
@synthesize titleLabel;
@synthesize timeLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.titleLabel setText:context.title];
    [self.textView setText:context.description];;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:context.setDate];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",formattedDate];

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

    self.textView.delegate = self;

    [self style];
    [self contentChanged];
}

- (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];
    [self.textView setBackgroundColor:[[Styler main] colorForKey:DarkGray]];
    [self.titleLabel setTextColor:[[Styler main] colorForKey:LightBlue]];
    [self.timeLabel setTextColor:[[Styler main] colorForKey:LightOrange]];
    [self.textView setTextColor:[[Styler main] colorForKey:White]];
    [self.imagesCollectionView setBackgroundColor:[[Styler main] colorForKey:EditableBackgroundGray]];
    [self.imagesCollectionView.layer setCornerRadius:5.0f];

    [self.imagesCollectionView.layer setBorderColor: [[[Styler main] colorForKey:Black] CGColor]];
    [self.imagesCollectionView.layer setBorderWidth:1];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addCollections];
    [self style];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addCollections {

    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset:UIEdgeInsetsMake(15,15,15,15)];
    [imagesCollectionView setCollectionViewLayout:layout animated:true];
    [imagesCollectionView setDataSource:self];
    [imagesCollectionView setDelegate:self];
    [imagesCollectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];

    cellWidth = (imagesCollectionView.frame.size.width-60)*0.333333333f;

    [imagesCollectionView registerClass:[CustomizeCollectionViewCell class] forCellWithReuseIdentifier:@"reusable_cell"];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    CustomizeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"reusable_cell" forIndexPath:indexPath];

    cell.backgroundColor=[[Styler main] colorForKey:DarkGray];
    [cell.layer setCornerRadius:5.0f];

    NSMutableArray *images = [NSMutableArray array];
    for (RLMImage *image in [context images]) {
        [images addObject:[UIImage imageWithData:image.imageData]];
    }

    [[cell imageView] setClipsToBounds:true];

    if (indexPath.row == [images count]) {
        UIImage *image = [UIImage imageNamed:@"plus"];
        image = [UIImage imageWithSize:CGSizeMake(cell.contentView.frame.size.width+20, cell.contentView.frame.size.height+20) image:image];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [[cell imageView] setImage:image];
        [[cell imageView] setTintColor:[[Styler main] colorForKey:White]];
    } else if (indexPath.row < images.count) {
        [cell.imageView.layer setCornerRadius:5.0f];
        [[cell imageView] setImage:[images objectAtIndex:indexPath.row]];
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [context images].count) [self addImage];
    else {
        UIImageView *imageView = [(CustomizeCollectionViewCell *)[imagesCollectionView cellForItemAtIndexPath:indexPath] imageView];
        UIImageView *newImageView = [UIImageView new];
        [newImageView setImage:imageView.image];
        CGRect fr = [[UIScreen mainScreen] bounds];
        CGRect new = CGRectMake(fr.origin.x, fr.origin.y-75, fr.size.width, fr.size.height);
        [newImageView setFrame:new];
        [newImageView setBackgroundColor:[[Styler main] colorForKey:DarkGray]];
        [newImageView setContentMode:UIViewContentModeScaleAspectFit];
        [newImageView setUserInteractionEnabled:true];

        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullscreenImage:)];
        UISwipeGestureRecognizer *rec2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullscreenImage:)];
        [newImageView addGestureRecognizer:recognizer];

        [self.view addSubview:newImageView];
        [self.navigationController.navigationBar setHidden:true];
        [self.tabBarController.tabBar setHidden:true];
    }
}

-(void)dismissFullscreenImage:(UITapGestureRecognizer *)sender {
    [self.navigationController.navigationBar setHidden:false];
    [self.tabBarController.tabBar setHidden:false];
    [sender.view removeFromSuperview];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (void)addImage {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Add Image" message:@"Would you like to add an image?" preferredStyle:UIAlertControllerStyleActionSheet];

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];

    UIViewController *cont __weak = self;
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.navigationBar.translucent = NO;
            pickerView.navigationBar.barTintColor = [UIColor colorWithRed:0.147 green:0.413 blue:0.737 alpha:1];
            pickerView.navigationBar.tintColor = [UIColor whiteColor];
            pickerView.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSLog(@"here1");
            [self presentViewController:pickerView animated:YES completion:nil];
        } else {
            NSLog(@"here2");
        }
    }]];

    [self presentViewController:actionSheet animated:true completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"YOOOOO");

    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    [[DataStore main] write:^{
        RLMImage *i = [[RLMImage alloc] init];
        i.imageData = UIImagePNGRepresentation(img);
        [[context images] addObject:i];
    }];

    [imagesCollectionView reloadData];

    [self.imagesCollectionView reloadData];
    [self.imagesCollectionView layoutIfNeeded];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [[DataStore main] write:^{
        context.description = textView.text;
    }];
    return true;
}

-(void) contentChanged {
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, CGFLOAT_MAX)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;

    CGRect contentRect = CGRectZero;

    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;

    textView.scrollEnabled = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
