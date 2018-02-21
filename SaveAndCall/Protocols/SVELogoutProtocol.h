//
//  SVELogoutProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 12/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

/*Протокол для для прерывания работы через вк, а также позволяет попасть в основное приложение без авторизации*/
@protocol SVELogoutProtocol <NSObject>

@optional

- (void)logout;
- (void)continueWitoutLogin;

@end
