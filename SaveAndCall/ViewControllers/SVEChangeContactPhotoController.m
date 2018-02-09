//
//  SVEChangeContactPhotoController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 02/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEChangeContactPhotoController.h"
#import "SVEChangePhotoView.h"
#import "SVEContactsTableViewController.h"
#import "SVEContactModel.h"
#import "SVESharedData.h"
#import "SVEFriendModel.h"
#import "NSString+SVENumberEraser.h"

@interface SVEChangeContactPhotoController ()

@property (nonatomic, strong) SVEChangePhotoView *changePhotoView;
@property (nonatomic, assign, getter=isPhotoChanged) BOOL photoChanged;

@end

@implementation SVEChangeContactPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Accept" style:UIBarButtonItemStylePlain target:self action:@selector(acceptButtonTapped)];
    //БЛЮР ЭФФЕКТ
    /*UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.view.bounds;
    [self.view addSubview:visualEffectView];*/
    
    /*NSArray* array = [self.tabBarController viewControllers];
    UINavigationController *cnc = [array firstObject];
    UIViewController *vc = [cnc.viewControllers objectAtIndex:0];*/
    
    //self.changePhotoView = [[SVEChangePhotoView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-115) vkPhoto:[UIImage imageWithData:self.contactsArray[self.index].imageData]];
   // [self.view addSubview:self.changePhotoView];
   // [self.changePhotoView updateConstraints];
    self.photoChanged = NO;
    [self changeContactPhoto];
}

- (void)changeContactPhoto
{
    if (![SVESharedData sharedData].vkFriendsWithTels.count)
    {
        self.changePhotoView = [[SVEChangePhotoView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-115) vkPhoto:nil];
        [self.view addSubview:self.changePhotoView];
        [self.changePhotoView updateConstraints];
        return;
    }
    for (SVEFriendModel *friend in [SVESharedData sharedData].vkFriendsWithTels)
    {
        NSString *findNumber = [friend.telNumberString sve_cutOffFirstDigit:friend.telNumberString];
        for (NSString *number in [SVESharedData sharedData].contacts[self.index].phonesArray)
        {
            NSString *tempNumber = [number sve_cutOffFirstDigit:number];
            if (![findNumber isEqualToString:tempNumber])
            {
                self.changePhotoView = [[SVEChangePhotoView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-115) vkPhoto:nil];
                [self.view addSubview:self.changePhotoView];
                [self.changePhotoView updateConstraints];
                return;
            }
            __block UIImage *image;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:friend.photo_200_Url]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.changePhotoView = [[SVEChangePhotoView alloc]
                                            initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-115) vkPhoto:image];
                    [self.view addSubview:self.changePhotoView];
                    [self.changePhotoView updateConstraints];
                    });
                });
                self.photoChanged = YES;
        }
    }
}

- (void)acceptButtonTapped
{
    if (!self.isPhotoChanged)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    self.contactsArray[self.index].imageData = UIImageJPEGRepresentation(self.changePhotoView.contactNewPhotoImageView.image, 1.f);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
