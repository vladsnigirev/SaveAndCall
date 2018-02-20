//
//  main.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 27/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSString *appDelegateClassString = NSClassFromString(@"XCTestCase") ? nil : NSStringFromClass([AppDelegate class]);
//        return UIApplicationMain(argc, argv, nil, appDelegateClassString);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
