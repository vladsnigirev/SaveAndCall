//
//  NSString+SVENumberEraser.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 08/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SVENumberEraser)
// отрезаем 8 или 7 от номера
- (NSString *)sve_cutOffFirstDigit:(NSString *)number;

@end
