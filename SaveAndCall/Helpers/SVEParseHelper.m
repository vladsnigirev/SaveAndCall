//
//  SVEParseService.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 01/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEParseHelper.h"
#import "SVEFriendModel.h"
#import "SVEContactModel.h"
#import <Contacts/Contacts.h>

@implementation SVEParseHelper
//Парсит массив моделей, полученных с помощью Contacts Framework и возвращает массив локальных моделей(SVEContactModel)
//@param contactsArray - массив моделей из Contacts Framework
+ (NSArray *)parseContactsArray:(NSArray *)contactsArray
{
    NSMutableArray *contactModelsArray = [NSMutableArray array];
    if (contactsArray)
    {
        @autoreleasepool
        {
            for (CNContact *contact in contactsArray)
            {
                SVEContactModel *contactModel = [[SVEContactModel alloc] initWithContact:contact];
                [contactModelsArray addObject:contactModel];
            }
        }
    }
    return [contactModelsArray copy];
}

//Парсит JSON, полученный с помощью запроса к vk API в массив моделей (SVEVkFriendModel)
//@param data - json, полученный из запроса
+ (NSArray *)parseVkFriendsFromData:(NSData *)data
{
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *friendsInfoArray = [JSONDictionary objectForKey:@"response"];
    NSMutableArray *friends = [NSMutableArray array];
    for (NSDictionary *friendInfo in friendsInfoArray)
    {
        @autoreleasepool
        {
            if (![friendInfo objectForKey:@"deactivated"])
            {
                SVEFriendModel *friend = [[SVEFriendModel alloc] initWithDictionary:friendInfo];
                [friends addObject:friend];
            }
        }
    }
    return [friends copy];
}

//Разбирает url содержащий токен, идентификатор и время "жизни" токена. Возвращает словарь с соответствующими ключами
// При возврате ошибки возвращает 0
//@param url - ответный url на запрос
+ (NSDictionary *)parseAuthorizationUrl:(NSURL *)url
{
    NSMutableDictionary *dictionaryWithToken = [NSMutableDictionary dictionary];
    if ([[url host] isEqualToString:@"authorize"])
    {
        NSString *query = url.absoluteString;
        NSArray *separatesArray = [query componentsSeparatedByString:@"#"];
        
        if (separatesArray.count > 1)
        {
            query = [separatesArray lastObject];
        }
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        for (NSString *pair in pairs)
        {
            NSArray *valuesInPairs = [pair componentsSeparatedByString:@"="];
            if ([[valuesInPairs firstObject] isEqualToString:@"error"])
            {
                return nil;
            }
            [dictionaryWithToken setObject:[valuesInPairs lastObject] forKey:[valuesInPairs firstObject]];
        }
    }
    return [dictionaryWithToken copy];
}

@end
