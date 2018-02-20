//
//  SVENetworkService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVENetworkServiceProtocol.h"


@class UIImage;
@interface SVENetworkService : NSObject


@property (nonatomic, weak) id<SVENetworkServiceProtocol> delegate;

//Получение списка друзей из Вконтакте
- (void)getFriends;
- (UIImage *)downloadImageByURL:(NSURL *)url;


@end
