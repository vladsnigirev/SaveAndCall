//
//  SVEChangePhotoView.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 02/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVEChangePhotoView : UIView

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIImageView *contactNewPhotoImageView;

- (instancetype)initWithFrame:(CGRect)frame vkPhoto:(UIImage *)vkPhoto;

@end
