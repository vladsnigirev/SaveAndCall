//
//  SVEUserDefaultsHelper.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 03/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

// Класс для работы с userDefauls. Осуществляет проверку актуальности токена в userDefaults.
// Также осуществляет удаления токена, когда пользователь выходит из ВК.
@interface SVEUserDefaultsHelper : NSObject

+ (BOOL)isLogged;
- (void)clearUserDefaults;

@end
