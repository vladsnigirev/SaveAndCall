//
//  SVEContactModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactRepresentation.h"
#import <Contacts/Contacts.h>
#import "SVEFriendRepresentation.h"
#import <UIKit/UIKit.h>

@interface SVEContactRepresentation ()

@property (nonatomic, readwrite) NSString *firstNameString;
@property (nonatomic, readwrite) NSString *lastNameString;
@property (nonatomic, readwrite) NSArray *phonesArray;

@end

@implementation SVEContactRepresentation

- (instancetype)initWithContact:(CNContact *)contact
{
    self = [super init];
    if (self)
    {
        self.phonesArray = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
        self.firstNameString = contact.givenName;
        self.lastNameString = contact.familyName;
        self.imageData = contact.thumbnailImageData;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    SVEContactRepresentation *copy = [[SVEContactRepresentation alloc] init];
    copy.firstNameString = [_firstNameString copy];
    copy.lastNameString = [_lastNameString copy];
    copy.phonesArray = [_phonesArray copy];
    copy.imageData = [_imageData copy];
    return copy;
}

- (instancetype)initWithFriend:(SVEFriendRepresentation *)friend
{
    self = [super init];
    if (self)
    {
        self.phonesArray = @[friend.phoneNumberString];
        self.firstNameString = friend.firstNameString;
        self.lastNameString = friend.lastNameString;
        self.imageData = UIImageJPEGRepresentation(friend.photo_100_image, 1);
    }
    return self;
}

@end
