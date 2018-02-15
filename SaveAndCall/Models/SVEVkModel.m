//
//  SVEVkModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkModel.h"
#import <UIKit/UIKit.h>
#import "SVEParseHelper.h"
#import "SVEFriendRepresentation.h"
#import "SVECoreDataService.h"

@interface SVEVkModel () 

@property (nonatomic, strong) SVECoreDataService *coreDataService;

@end

@implementation SVEVkModel

- (void)configureModelWithData:(NSData *)data;
{
    if (!data)
    {
        self.vkFriends = [self.coreDataService friensFromCoreData];
        return;
    }
    self.vkFriends = [SVEParseHelper parseVkFriendsFromData:data];
}

- (NSUInteger)countOfVkFriends
{
    return self.vkFriends.count;
}


@end
