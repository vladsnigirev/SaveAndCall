//
//  SVEContactTableCellTableViewCell.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SVEContactRepresentation;

@interface SVEContactsTableCell : UITableViewCell


@property (nonatomic, strong) UILabel *firstNameLabel;
@property (nonatomic, strong) UILabel *lastNameLabel;
@property (nonatomic, strong) UIImageView *profilePhotoImageView;
@property (nonatomic, strong) UILabel *firstPhoneLabel;

- (SVEContactsTableCell *)configureCell:(SVEContactsTableCell *)cell withContact:(SVEContactRepresentation *)contact;


@end
