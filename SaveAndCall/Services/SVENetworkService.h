//
//  SVENetworkService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVENetworkServiceProtocol.h"

@interface SVENetworkService : NSObject 

@property (nonatomic, weak) id<SVENetworkServiceProtocol> delegate;
//запрос для получения друзей
- (void)getFriends;


@end
