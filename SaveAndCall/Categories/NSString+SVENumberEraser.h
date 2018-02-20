//
//  NSString+SVENumberEraser.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 08/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (SVENumberEraser)
// Функция "отрезает" 8 или 7 от номера, приведенного к строке, содержащей только цифры.
- (NSString *)sve_cutOffFirstDigit:(NSString *)number;

@end
