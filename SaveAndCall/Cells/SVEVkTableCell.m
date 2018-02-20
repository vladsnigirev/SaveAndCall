//
//  SVEVkTableCell.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkTableCell.h"
#import "Masonry.h"
#import "SVEFriendRepresentation.h"


@implementation SVEVkTableCell


#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _firstNameLabel = [UILabel new];
        _firstNameLabel.numberOfLines = 0;
        _lastNameLabel = [UILabel new];
        _lastNameLabel.numberOfLines = 0;
        _profilePhotoImageView = [[UIImageView alloc] init];
        self.profilePhotoImageView.layer.cornerRadius = 50;
        self.profilePhotoImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_firstNameLabel];
        [self.contentView addSubview:_lastNameLabel];
        [self.contentView addSubview:_profilePhotoImageView];
    }
    return self;
}


#pragma mark - UIView

- (void)updateConstraints
{
    [self.profilePhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(20);
        make.bottom.equalTo(self.contentView).with.offset(-20);
    }];
    [self.firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(self.profilePhotoImageView.mas_right).with.offset(40);
        make.top.equalTo(self.profilePhotoImageView.mas_top).with.offset(25);
        make.right.lessThanOrEqualTo(self.contentView).with.offset(-20);
    }];
    [self.lastNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(self.firstNameLabel.mas_right).with.offset(7);
        make.top.equalTo(self.firstNameLabel.mas_top);
    }];
    [super updateConstraints];
}


#pragma mark - Public

- (SVEVkTableCell *)configureCell:(SVEVkTableCell *)cell withFriend:(SVEFriendRepresentation *)friend
{
    cell.firstNameLabel.text = friend.firstNameString;
    cell.lastNameLabel.text = friend.lastNameString;
    cell.profilePhotoImageView.image = friend.photo_100_image;
    return cell;
}


@end
