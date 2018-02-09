//
//  SVESharedDataProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 07/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
// Не используется
@protocol SVEFillSharedDataProtocol <NSObject>
@optional
- (void)fillSharedDataWithFriendsArray:(NSArray *)friendsArray;
- (void)fillSharedDataWithContactsArray:(NSArray *)contactsArray;

@end
//Не используется
@protocol SVEUseSharedDataProtocol <NSObject>

@end
