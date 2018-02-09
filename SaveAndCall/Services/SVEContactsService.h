//
//  SVEContactsService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVEContactsProtocol.h"

@interface SVEContactsService : NSObject

@property (nonatomic, weak) id <SVEContactsProtocol> delegate;

-(void)getContacts;

@end
