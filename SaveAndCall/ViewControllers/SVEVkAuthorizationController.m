//
//  SVEVkAuthorizationController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 27/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkAuthorizationController.h"
#import "SVEVkAuthorizationService.h"
#import "SVETokenService.h"
#import "AppDelegate.h"


static const NSUInteger SVEAuthorizationButtonOxOffsett = 30;
static const NSUInteger SVEAuthorizationButtonOyOffsett = 200;
static const NSUInteger SVEAuthorizationButtonCornerRadius = 10;
static const NSUInteger SVEAuthorizationButtonHeight = 60;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonOxOffsett = 30;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonOyOffsett = 100;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonCornerRadius = 10;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonHeight = 60;


@interface SVEVkAuthorizationController ()


@property (nonatomic, strong) SVEVkAuthorizationService *authorizationService;
@property (nonatomic, strong) UIButton *authorizationButton;
@property (nonatomic, strong) UIButton *continueWithoutAuthorizationButton;
@property (nonatomic, strong) SVETokenService *tokenService;
@property (nonatomic, strong) UIImageView *backgroundImage;


@end

@implementation SVEVkAuthorizationController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.tokenService.delegate = self;
    self.tokenService = appDelegate.tokenService;
    self.authorizationService = [[SVEVkAuthorizationService alloc] init];
    self.authorizationService.SVEVkAuthorizationController = self;
    [self setupBackgroundView];
    [self setupButtons];
}



#pragma mark - View customization

- (void)setupBackgroundView
{
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lastauth"]];
    self.backgroundImage.frame = self.view.bounds;
    self.backgroundImage.clipsToBounds = YES;
    [self.view addSubview:self.backgroundImage];
}
#pragma mark - Buttons' customization

- (void)setupButtons
{
    self.authorizationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.authorizationButton.frame = CGRectMake(SVEAuthorizationButtonOxOffsett,
                                                CGRectGetHeight(self.view.frame) - SVEAuthorizationButtonOyOffsett,
                                                CGRectGetWidth(self.view.frame) - SVEAuthorizationButtonOxOffsett * 2,
                                                SVEAuthorizationButtonHeight);
    self.authorizationButton.layer.cornerRadius = SVEAuthorizationButtonCornerRadius;
    self.authorizationButton.clipsToBounds = YES;
    [self.authorizationButton setImage:[UIImage imageNamed:@"authbut"] forState:UIControlStateNormal];
    [self.authorizationButton addTarget:self action:@selector(authorizeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.continueWithoutAuthorizationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.continueWithoutAuthorizationButton.frame = CGRectMake(SVEcontinueWithoutAuthorizationButtonOxOffsett,
                                                               CGRectGetHeight(self.view.frame)
                                                               - SVEcontinueWithoutAuthorizationButtonOyOffsett,
                                                               CGRectGetWidth(self.view.frame)
                                                               - SVEcontinueWithoutAuthorizationButtonOxOffsett * 2,
                                                               SVEcontinueWithoutAuthorizationButtonHeight);
    self.continueWithoutAuthorizationButton.layer.cornerRadius = SVEcontinueWithoutAuthorizationButtonCornerRadius;
    self.continueWithoutAuthorizationButton.clipsToBounds = YES;
    [self.continueWithoutAuthorizationButton setTitle:@"Continue without authorization" forState:UIControlStateNormal];
    [self.continueWithoutAuthorizationButton setImage:[UIImage imageNamed:@"continuebut"] forState:UIControlStateNormal];
    [self.continueWithoutAuthorizationButton addTarget:self action:@selector(continueButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.authorizationButton];
    [self.view addSubview:self.continueWithoutAuthorizationButton];
}


#pragma mark - Buttons methods

- (void)authorizeButtonClicked
{
    [self.authorizationService authorize];
}

- (void)continueButtonClicked
{
    [self.tokenService continueWithoutAuthorization];
}


@end
