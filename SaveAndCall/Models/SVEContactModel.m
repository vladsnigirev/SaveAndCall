//
//  SVEContactModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactModel.h"
#import <Contacts/Contacts.h>

@interface SVEContactModel ()

@property (nonatomic, readwrite) NSString *firstNameString;
@property (nonatomic, readwrite) NSString *lastNameString;
@property (nonatomic, readwrite) NSArray *phonesArray;

@end

@implementation SVEContactModel

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

@end
