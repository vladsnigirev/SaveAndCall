//
//  SVEFriendModel.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage, SVECoreDataFriendModel, SVEContactRepresentation;

@interface SVEFriendRepresentation : NSObject <NSCopying>


@property (nonatomic, readonly) NSString *firstNameString;
@property (nonatomic, readonly) NSString *lastNameString;
@property (nonatomic, readonly) NSURL *photo_100_Url;
@property (nonatomic, readonly) NSURL *photo_200_Url;
@property (nonatomic, copy) NSString *phoneNumberString;
@property (nonatomic, strong) UIImage *photo_100_image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithCoreData:(SVECoreDataFriendModel *)coreDataFriend;
- (BOOL)isEqualTo:(SVEFriendRepresentation *)friend;


@end
