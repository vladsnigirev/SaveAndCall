//
//  SVEFriendModel.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@interface SVEFriendModel : NSObject

@property (nonatomic, strong) NSString *firstNameString;
@property (nonatomic, strong) NSString *lastNameString;
@property (nonatomic, strong) NSURL *photo_100_Url;
@property (nonatomic, strong) NSURL *photo_200_Url;
@property (nonatomic, strong) NSString *telNumberString;
@property (nonatomic, strong) UIImage *photo_100_image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
