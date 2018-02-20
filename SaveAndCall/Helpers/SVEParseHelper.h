//
//  SVEParseService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SVEFriendRepresentation,SVEContactRepresentation;


//Класс для парсинга различных сущностей.
@interface SVEParseHelper : NSObject


+ (NSArray<SVEContactRepresentation *> *)parseContactsArray:(NSArray *)contactsArray;
+ (NSArray<SVEFriendRepresentation *> *)parseVkFriendsFromData:(NSData *)data;
+ (NSDictionary *)parseAuthorizationUrl:(NSURL *)url;


@end
