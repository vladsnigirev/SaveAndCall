//
//  SVEVkModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEParseHelper.h"
#import "SVEFriendRepresentation.h"
#import "SVECoreDataService.h"
#import "SVEVkModel.h"


@interface SVEVkModel () 


@property (nonatomic, strong) SVECoreDataService *coreDataService;


@end

@implementation SVEVkModel


#pragma mark - Public

- (void)configureModelWithData:(NSData *)data;
{
    self.coreDataService = [SVECoreDataService new];
    self.vkFriends = [SVEParseHelper parseVkFriendsFromData:data];
    if (!self.vkFriends)
    {
        self.vkFriends = [self.coreDataService friendsFromCoreData];
        return;
    }
    [self.coreDataService saveFriends];
}

- (NSUInteger)countOfVkFriends
{
    return self.vkFriends.count;
}


@end
