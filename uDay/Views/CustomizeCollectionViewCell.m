//
//  CustomizeCollectionViewCell.m
//  uDay
//
//  Created by Andriko on 2/6/18.
//  Copyright © 2018 Andriko. All rights reserved.
//

#import "CustomizeCollectionViewCell.h"

@interface CustomizeCollectionViewCell ()
{
    UIImageView *_imageView;
}
@end

@implementation CustomizeCollectionViewCell

- (UIImageView *) imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

-(void)prepareForReuse
{
    [super prepareForReuse];

    [self.imageView removeFromSuperview];
    _imageView = nil;
}
@end
