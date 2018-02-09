//
//  SVESharedData.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 07/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

// Класс для общих данных. Синглтон. Содержит 2 массива.
// массив друзей только у которых заполенан строка телефонов
// массив контактов (всех)
@class SVEContactModel;
@interface SVESharedData : NSObject

@property (nonatomic, strong) NSArray *vkFriendsWithTels;
@property (nonatomic, strong) NSArray<SVEContactModel *> *contacts;

+ (instancetype)sharedData;

@end
