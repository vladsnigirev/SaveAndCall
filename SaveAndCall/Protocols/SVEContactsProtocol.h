//
//  SVEContactsProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//
#import <Contacts/Contacts.h>

@protocol SVEContactsProtocol <NSObject>
@required
- (void)gotContactsWithArray:(NSArray<CNContact *>  *)contactsArray;

@end
