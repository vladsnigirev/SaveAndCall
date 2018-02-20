//
//  SVESynchronizationService.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVESynchronizationService.h"
#import "SVEVkModel.h"
#import "SVEFriendRepresentation.h"
#import "SVEContactRepresentation.h"
#import "AppDelegate.h"
#import "NSString+SVENumberEraser.h"


@interface SVESynchronizationService ()


@property (nonatomic, copy) NSArray *friendsArray;
@property (nonatomic, copy) NSArray *contactsArray;


@end

@implementation SVESynchronizationService


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _friendsArray = [[NSArray alloc] initWithArray:appDelegate.vkModel.vkFriends copyItems:YES];
        _contactsArray = [[NSArray alloc] initWithArray:appDelegate.contactsModel.contacts copyItems:YES];
    }
    return self;
}


#pragma mark - Public

- (NSArray *)synchronizeContactsWithfriends
{
    NSArray *friendsWithPhones = [self findfriendsWithPhones];
    NSArray *newContacts = [self customizeContactsPhones];
    
    NSMutableSet *vkPhonesSet = [NSMutableSet set];
    for (SVEFriendRepresentation *friend in friendsWithPhones)
    {
        [vkPhonesSet addObject:friend.phoneNumberString];
    }
    NSMutableSet *contactsPhonesSet = [[NSMutableSet alloc] initWithArray:newContacts];
    NSMutableSet *intersec = [vkPhonesSet mutableCopy];
    [intersec intersectSet:contactsPhonesSet];
    NSMutableSet *result = [vkPhonesSet mutableCopy];
    [result minusSet:intersec];
    NSArray *synchronizedArray = [result allObjects];
    synchronizedArray = [self updateModel:synchronizedArray];
    [self friendsToContacts:synchronizedArray];
    return synchronizedArray;
}


#pragma mark - Private

//Возвращает массив друзей из вк с телефонами. Приводит телефоны к 10 значному виду, т.е. без 7,8.
- (NSArray *)findfriendsWithPhones
{
    if (!self.friendsArray)
    {
        return nil;
    }
    NSMutableArray *temporaryArray = [NSMutableArray array];
    for (SVEFriendRepresentation *friend in self.friendsArray)
    {
        if (!(friend.phoneNumberString || [friend.phoneNumberString length] > 10))
        {
            continue;
        }
        friend.phoneNumberString = [[friend.phoneNumberString componentsSeparatedByCharactersInSet:
                                                   [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                  componentsJoinedByString:@""];
        friend.phoneNumberString = [friend.phoneNumberString sve_cutOffFirstDigit:friend.phoneNumberString];
        if (!(friend.phoneNumberString.length == 10))
        {
            continue;
        }
        [temporaryArray addObject:friend];
    }
    return [temporaryArray copy];
}

//Разбирает массив контактов, получая оттуда все телефоны, и возвращает массив телефонов.
//Приводит телефоны к 10 значному виду, т.е. без 7,8.
- (NSArray *)customizeContactsPhones
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (SVEContactRepresentation *contact in self.contactsArray)
    {
        if (!contact.phonesArray)
        {
            continue;
        }
        for (NSString *phone in contact.phonesArray)
        {
            NSString * changedPhone;
            changedPhone = [[phone componentsSeparatedByCharactersInSet:
                                     [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                    componentsJoinedByString:@""];
            changedPhone = [changedPhone sve_cutOffFirstDigit:changedPhone];
            [tempArray addObject:changedPhone];
        }
    }
    return [tempArray copy];
}

//Синхронизирует массив телефонов с друзьями из вк. Возвращает массив друзей, которым принадлежат телефоны.
- (NSArray *)updateModel:(NSArray *)additionalFriends
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (SVEFriendRepresentation *friend in self.friendsArray)
    {
        for (NSString *phone in additionalFriends)
        {
            if (phone == friend.phoneNumberString)
            {
                [mutableArray addObject:friend];
            }
        }
    }
    return [mutableArray copy];
}

//Преобразует массив друзей в массив контактов. Обновляет модель контактов.
//@param NSArray - массив друзей, которых нужно перенести в контакты.
- (void)friendsToContacts:(NSArray *)array
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *marray = appDelegate.vkModel.vkFriends;
    NSMutableArray *changedContacts = [appDelegate.contactsModel.contacts mutableCopy];
    for (SVEFriendRepresentation *modelFriend in array)
    {
        for (SVEFriendRepresentation *friend in marray)
        {
            if ([modelFriend isEqualTo:friend])
            {
                SVEContactRepresentation *contact = [[SVEContactRepresentation alloc] initWithFriend:friend];
                [changedContacts addObject:contact];
            }
        }
    }
    NSArray *sortedArray;
    sortedArray = [changedContacts sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *obj1Surname = [(SVEContactRepresentation *)obj1 lastNameString];
        NSString *obj2Surname = [(SVEContactRepresentation *)obj2 lastNameString];
        return [obj1Surname compare:obj2Surname];
    }];
    appDelegate.contactsModel.contacts = sortedArray;
}


@end
