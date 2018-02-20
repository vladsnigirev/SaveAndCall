//
//  SVEChangePhotoView.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 02/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SVEContactRepresentation;
@interface SVEChangePhotoView : UIView


@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIImageView *contactNewPhotoImageView;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *lastNameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

- (instancetype)initWithFrame:(CGRect)frame contact:(SVEContactRepresentation *)contact;


@end
