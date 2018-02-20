//
//  NSString+SVENumberEraser.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 08/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "NSString+SVENumberEraser.h"

@implementation NSString (SVENumberEraser)

#pragma mark - Public

- (NSString *)sve_cutOffFirstDigit:(NSString *)number
{
    if (number.length == 11)
    {
        number = [number substringFromIndex:1];
    }
    return number;
}

@end
