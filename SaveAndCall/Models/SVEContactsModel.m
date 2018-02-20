//
//  SVEContactsModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactsModel.h"
#import "SVEParseHelper.h"


@implementation SVEContactsModel


#pragma mark - Public

- (void)configureModelWithContactsArray:(NSArray *)contactsArray
{
    if (!contactsArray)
    {
        self.contacts = nil;
        return;
    }
        self.contacts = [SVEParseHelper parseContactsArray:contactsArray];
}

-(NSUInteger)countOfContacts
{
    return self.contacts.count;
}

@end
