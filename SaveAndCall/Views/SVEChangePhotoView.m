//
//  SVEChangePhotoView.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 02/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEChangePhotoView.h"
#import "Masonry.h"
#import "SVEContactRepresentation.h"

@implementation SVEChangePhotoView

- (instancetype)initWithFrame:(CGRect)frame contact:(SVEContactRepresentation *)contact
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _headLabel = [UILabel new];
        _headLabel.numberOfLines = 0;
        _headLabel.text = @"This is beta version of the application!";
        _contactNewPhotoImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:contact.imageData]];
        _contactNewPhotoImageView.layer.cornerRadius = 15;
        _contactNewPhotoImageView.clipsToBounds = YES;
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = contact.firstNameString;
        _lastNameLabel = [UILabel new];
        _lastNameLabel.numberOfLines = 0;
        _lastNameLabel.text = contact.lastNameString;
        _phoneLabel = [UILabel new];
        _phoneLabel.numberOfLines = 0;
        _phoneLabel.text = contact.phonesArray[0];
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:_headLabel];
        [self addSubview:_nameLabel];
        [self addSubview:_lastNameLabel];
        [self addSubview:_phoneLabel];
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
        make.top.equalTo(self).with.offset(5);
    }];
    [self.contactNewPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(100);
        make.width.mas_lessThanOrEqualTo(100);
        make.top.lessThanOrEqualTo(self.headLabel.mas_bottom).with.offset(50);
       // make.left.lessThanOrEqualTo(self).with.offset(10);
       // make.right.lessThanOrEqualTo(self).with.offset(-10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        //make.left.equalTo(self.contactNewPhotoImageView.mas_right).with.offset(15);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.contactNewPhotoImageView.mas_bottom).with.offset(10);
        
    }];
    [self.lastNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.mas_centerX);
        //make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(15);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.lastNameLabel.mas_bottom).with.offset(15);
    }];
    [super updateConstraints];
}

@end
