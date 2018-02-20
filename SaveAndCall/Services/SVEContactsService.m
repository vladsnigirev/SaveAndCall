//
//  SVEContactsService.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactsService.h"
#import <Contacts/Contacts.h>


@implementation SVEContactsService


#pragma mark - Public

- (void)getContacts
{
    NSMutableArray *contactsArray = [NSMutableArray array];
    if ([CNContactStore class])
    {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        NSArray *keysForContactRequest = @[CNContactGivenNameKey,
                                           CNContactFamilyNameKey,
                                           CNContactPhoneNumbersKey,
                                           CNContactImageDataAvailableKey,
                                           CNContactImageDataKey,
                                           CNContactThumbnailImageDataKey];
        CNContactFetchRequest *contactFetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysForContactRequest];
        contactFetchRequest.sortOrder = CNContactSortOrderGivenName;
        
        [contactStore enumerateContactsWithFetchRequest:contactFetchRequest
                                                  error:nil
                                             usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            if (contact)
            {
                [contactsArray addObject:contact];
            }
        }];
        [self.delegate gotContactsWithArray:[contactsArray copy]];
    }
}


@end
