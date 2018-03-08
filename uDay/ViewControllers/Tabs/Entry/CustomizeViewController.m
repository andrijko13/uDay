//
//  CustomizeViewController.m
//  uDay
//
//  Created by Andriko on 2/3/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "CustomizeViewController.h"

@interface CustomizeViewController ()
{
    double cellWidth;
    NSMutableArray *images;
}

@end

@implementation CustomizeViewController
@synthesize doneButton;
@synthesize addToMapButton;
@synthesize imagesCollectionView;
@synthesize context;

- (void)style {
    [self.view setBackgroundColor: [[Styler main] colorForKey:DarkGray]];
    [self.imagesCollectionView setBackgroundColor:[[Styler main] colorForKey:EditableBackgroundGray]];
    [doneButton setBackgroundColor:[[Styler main] colorForKey:LightBlue]];
    [addToMapButton setBackgroundColor:[[Styler main] colorForKey:LightOrange]];

    [self.doneButton.layer setCornerRadius:5.0f];
    [self.addToMapButton.layer setCornerRadius:5.0f];
    [self.imagesCollectionView.layer setCornerRadius:5.0f];

    [self.imagesCollectionView.layer setBorderColor: [[[Styler main] colorForKey:Black] CGColor]];
    [self.imagesCollectionView.layer setBorderWidth:1];

    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [addToMapButton setTitle:@"Add Location" forState:UIControlStateNormal];
    [doneButton setTitleColor:[[Styler main] colorForKey:White] forState:UIControlStateNormal];
    [addToMapButton setTitleColor:[[Styler main] colorForKey:White] forState:UIControlStateNormal];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self style];
    images = [NSMutableArray arrayWithCapacity:12];
    cellWidth = imagesCollectionView.frame.size.width-60;
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [self addCollections];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
    CustomizeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"reusable_cell" forIndexPath:indexPath];

    cell.backgroundColor=[[Styler main] colorForKey:DarkGray];
    [cell.layer setCornerRadius:5.0f];

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
    if (indexPath.row == images.count) [self addImage];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, cellWidth);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"YOOOOO");

    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    [images addObject:img];

    [self.imagesCollectionView reloadData];
    [self.imagesCollectionView layoutIfNeeded];

//    CustomizeCollectionViewCell *cell =  (CustomizeCollectionViewCell *)[self.imagesCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
//    [[cell imageView] setImage:img];
}

- (IBAction)addToMapClicked:(id)sender {

}

- (IBAction)doneButtonClicked:(id)sender {
    Entry *e = context;
    for (UIImage *image in images) {
        RLMImage *i = [[RLMImage alloc] init];
        i.imageData = UIImagePNGRepresentation(image);
        [e.images addObject:i];
    }

    [[DataStore main] addEntry:e];
    [self.navigationController popToRootViewControllerAnimated:true];
}
@end
