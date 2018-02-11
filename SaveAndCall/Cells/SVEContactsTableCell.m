//
//  SVEContactTableCellTableViewCell.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactsTableCell.h"
#import "Masonry.h"
#import "SVEContactModel.h"

@implementation SVEContactsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _firstNameLabel = [[UILabel alloc] init];
        _firstNameLabel.numberOfLines = 0;
        _lastNameLabel = [[UILabel alloc] init];
        _lastNameLabel.numberOfLines = 0;
        _profilePhotoImageView = [[UIImageView alloc] init];
        _firstPhoneLabel = [[UILabel alloc] init];
        _firstPhoneLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_firstNameLabel];
        [self.contentView addSubview:_lastNameLabel];
        [self.contentView addSubview:_profilePhotoImageView];
        [self.contentView addSubview:_firstPhoneLabel];
    }
    return self;
}

- (void)updateConstraints
{
    [self.profilePhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(20);
        make.bottom.equalTo(self.contentView).with.offset(-20);
    }];
    [self.firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(self.profilePhotoImageView.mas_right).with.offset(20);
        make.top.equalTo(self.profilePhotoImageView.mas_top);
        make.right.equalTo(self.contentView).with.offset(-20);
    }];
    [self.lastNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(self.firstNameLabel.mas_left);
        make.top.equalTo(self.firstNameLabel.mas_bottom).with.offset(20);
        make.right.equalTo(self.firstNameLabel);
    }];
    [self.firstPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.left.equalTo(self.firstNameLabel.mas_left);
        make.top.equalTo(self.lastNameLabel.mas_bottom).with.offset(15);
    }];
    self.profilePhotoImageView.layer.cornerRadius = 50;
    self.profilePhotoImageView.clipsToBounds = YES;
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (SVEContactsTableCell *)configureCell:(SVEContactsTableCell *)cell withContact:(SVEContactModel *)contact
{
    cell.firstNameLabel.text = contact.firstNameString;
    cell.lastNameLabel.text = contact.lastNameString;
    cell.profilePhotoImageView.image = [UIImage imageWithData:contact.imageData];
    if (!contact.phonesArray.count)
    {
        cell.firstPhoneLabel.text = nil;
    }
    else
    {
        cell.firstPhoneLabel.text = contact.phonesArray[0];
    }
    return cell;
}

@end
