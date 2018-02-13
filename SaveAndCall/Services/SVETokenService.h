//
//  SVEUserDefaultsHelper.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVERouterProtocol.h"
#import "SVELogoutProtocol.h"

// Класс для работы с userDefauls. Осуществляет проверку актуальности токена в userDefaults.
// Также осуществляет удаления токена, когда пользователь выходит из ВК.
@interface SVETokenService : NSObject

@property (nonatomic, weak) id<SVERouterProtocol> router;
@property (nonatomic, weak) id<SVELogoutProtocol> delegate;

- (BOOL)isLogged;
- (void)clearUserDefaults;
- (void)continueWithoutAuthorization;

@end
