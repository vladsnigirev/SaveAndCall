//
//  SVEChangePhotoView.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 02/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEChangePhotoView.h"
#import "Masonry.h"

@implementation SVEChangePhotoView

- (instancetype)initWithFrame:(CGRect)frame vkPhoto:(UIImage *)vkPhoto
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _headLabel = [UILabel new];
        _headLabel.numberOfLines = 0;
        _headLabel.text = @"New Contacts photo:";
        _contactNewPhotoImageView = [[UIImageView alloc] initWithImage:vkPhoto];
        _contactNewPhotoImageView.layer.cornerRadius = 50;
        _contactNewPhotoImageView.clipsToBounds = YES;
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:_headLabel];
        [self addSubview:_contactNewPhotoImageView];
    }
    return self;
}

- (void)updateConstraints
{
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
    }];
    [self.contactNewPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(100);
        make.width.mas_lessThanOrEqualTo(100);
        make.top.lessThanOrEqualTo(self.headLabel.mas_bottom).with.offset(50);
        make.left.lessThanOrEqualTo(self).with.offset(10);
        make.right.lessThanOrEqualTo(self).with.offset(-10);
        make.center.equalTo(self);
    }];
    [super updateConstraints];
}

@end
