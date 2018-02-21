//
//  SVERouterProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 12/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//


/*Протокол для смены экранов*/
@protocol SVERouterProtocol <NSObject>

- (void)switchAuthorizationControllerToMain;
- (void)switchMainControllerToAuthorization;

@end
