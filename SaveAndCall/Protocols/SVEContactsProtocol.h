//
//  SVEContactsProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

/*Протокол для обработки полученных контактов*/
@class CNContact;
@protocol SVEContactsProtocol <NSObject>


@required
- (void)gotContactsWithArray:(NSArray<CNContact *> *)contactsArray;


@end
