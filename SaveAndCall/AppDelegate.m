//
//  AppDelegate.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 27/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "AppDelegate.h"
#import "SVEVkAuthorizationController.h"
#import "SVETabBarController.h"
#import "SVEVkFriendsNavigationController.h"
#import "SVEVkTableViewController.h"
#import "SVEContactsNavigationController.h"
#import "SVEContactsTableViewController.h"
#import "SVEUserDefaultsHelper.h"
#import "SVERouter.h"

static NSString *const SVEAppGotInformationAfterAutorization = @"SVEAppGotInformationAfterAutorization";

@interface AppDelegate ()

@property (nonatomic, strong) SVERouter *router;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.router = [[SVERouter alloc] init];
    [self.router setDefinedViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SaveAndCall"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSDictionary *dictionaryForUserInfo = [NSDictionary dictionaryWithObject:url forKey:@"Url"];
    [[NSNotificationCenter defaultCenter] postNotificationName:SVEAppGotInformationAfterAutorization object:nil userInfo:dictionaryForUserInfo];
    return YES;
}

@end
