//
//  SVESynchronizationService.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVESynchronizationService : NSObject

//Функция для синхронизации друзей вк с телелфонами и контактов. Обновляет модель контактов,
//добавляя новые контакты в список. Если номера у существующего номера и нового совпадают, остается существующий.
- (NSArray *)synchronizeContactsWithfriends;

@end
