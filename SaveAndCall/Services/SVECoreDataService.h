//
//  SVECoreDataService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 13/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVEFriendModel;
@interface SVECoreDataService : NSObject

- (void)saveFriends:(NSArray<SVEFriendModel *> *)friends;
- (NSArray *)friensFromCoreData;

@end
