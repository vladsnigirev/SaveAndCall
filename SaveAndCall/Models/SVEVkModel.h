//
//  SVEVkModel.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 14/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SVEVkModel : NSObject


@property (nonatomic, copy) NSArray *vkFriends;

- (void)configureModelWithData:(NSData *)data;
- (NSUInteger)countOfVkFriends;


@end
