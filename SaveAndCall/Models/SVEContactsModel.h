//
//  SVEContactsModel.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVEContactsModel : NSObject

@property (nonatomic, copy) NSArray *contacts;

- (void)configureModelWithContactsArray:(NSArray *)contactsArray;

- (NSUInteger)countOfContacts;

@end
