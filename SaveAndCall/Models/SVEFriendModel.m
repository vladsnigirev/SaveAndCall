//
//  SVEFriendModel.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEFriendModel.h"
#import <UIKit/UIKit.h>

@implementation SVEFriendModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _firstNameString = [dict objectForKey:@"first_name"];
        _lastNameString = [dict objectForKey:@"last_name"];
        NSString *telString = [dict objectForKey:@"mobile_phone"];
        if (![telString isEqualToString:@""])
        {
            _telNumberString = telString;
        }
        else
        {
            _telNumberString = nil;
        }
        NSString *photo100String = [dict objectForKey:@"photo_100"];
        if(photo100String)
        {
        _photo_100_Url = [NSURL URLWithString:photo100String];
        }
        NSString *photo200String = [dict objectForKey:@"photo_200_orig"];
        if(photo200String)
        {
            _photo_200_Url = [NSURL URLWithString:photo200String];
        }
        _photo_100_image = nil;
    }
    return self;
}

@end
