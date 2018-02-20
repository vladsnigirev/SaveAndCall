//
//  SVEFriendModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEFriendRepresentation.h"
#import <UIKit/UIKit.h>
#import "SVECoreDataFriendModel+CoreDataClass.h"


@interface SVEFriendRepresentation ()


@property (nonatomic, readwrite) NSString *firstNameString;
@property (nonatomic, readwrite) NSString *lastNameString;
@property (nonatomic, readwrite) NSURL *photo_100_Url;
@property (nonatomic, readwrite) NSURL *photo_200_Url;


@end


@implementation SVEFriendRepresentation


#pragma mark - Lifecycle

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _firstNameString = [dict objectForKey:@"first_name"];
        _lastNameString = [dict objectForKey:@"last_name"];
        NSString *telString = [dict objectForKey:@"mobile_phone"];
        if (![telString isEqualToString:@""])
        {
            _phoneNumberString = telString;
        }
        else
        {
            _phoneNumberString = nil;
        }
        NSString *photo100String = [dict objectForKey:@"photo_100"];
        if(photo100String)
        {
        _photo_100_Url = [NSURL URLWithString:photo100String];
        }
        NSString *photo200String = [dict objectForKey:@"photo_200_orig"];
        if(photo200String)
        {
            _photo_200_Url = [NSURL URLWithString:photo200String];
        }
        _photo_100_image = nil;
    }
    return self;
}

- (instancetype)initWithCoreData:(SVECoreDataFriendModel *)coreDataFriend
{
    {
        self = [super init];
        if (self)
        {
            _firstNameString = coreDataFriend.firstName;
            _lastNameString = coreDataFriend.lastName;
            _phoneNumberString = coreDataFriend.phoneNumber;
            _photo_100_Url = nil;
            _photo_200_Url = nil;
            _photo_100_image = [UIImage imageNamed:@"user logo"];
        }
        return self;
    }
}


#pragma mark - Public

- (BOOL)isEqualTo:(SVEFriendRepresentation *)friend
{
    if ([self.firstNameString isEqualToString:friend.firstNameString]
        && [self.lastNameString isEqualToString:friend.lastNameString]
        && [self.photo_100_Url isEqual:friend.photo_100_Url]
        && [self.photo_200_Url isEqual:friend.photo_200_Url])
    {
        return YES;
    }
    if (self.photo_100_Url == nil
        && self.photo_200_Url == nil
        && [self.firstNameString isEqualToString:friend.firstNameString]
        && [self.lastNameString isEqualToString:friend.lastNameString])
    {
        return  YES;
    }
    return NO;
}


#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    SVEFriendRepresentation *copy = [[SVEFriendRepresentation alloc] init];
    copy.firstNameString = [_firstNameString copy];
    copy.lastNameString = [_lastNameString copy];
    copy.phoneNumberString = [_phoneNumberString copy];
    copy.photo_100_Url = [_photo_100_Url copy];
    copy.photo_200_Url = [_photo_200_Url copy];
    copy.photo_100_image = [_photo_100_image copy];
    return copy;
}


@end
