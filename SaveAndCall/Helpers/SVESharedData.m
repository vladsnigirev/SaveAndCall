//
//  SVESharedData.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 07/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVESharedData.h"

@implementation SVESharedData

+ (instancetype)sharedData
{
    static SVESharedData *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[SVESharedData alloc] init];
    });
    return sharedData;
}

@end
