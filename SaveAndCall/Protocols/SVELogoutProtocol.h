//
//  SVELogoutProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 12/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>
//Протокол для смены статуса авторизованности в вк
@protocol SVELogoutProtocol <NSObject>

@optional

- (void)logout;
- (void)continueWitoutLogin;

@end
