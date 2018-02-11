//
//  SVEVkTableCell.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 28/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVEFriendModel;
@interface SVEVkTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *firstNameLabel;
@property (nonatomic, strong) UILabel *lastNameLabel;
@property (nonatomic, strong) UIImageView *profilePhotoImageView;

- (SVEVkTableCell *)configureCell:(SVEVkTableCell *)cell withFriend:(SVEFriendModel *)friend;

@end
