//
//  SVEVkAuthorizationController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 27/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkAuthorizationController.h"
#import "SVEVkAuthorizationService.h"

static NSString *const SVEContinueWithoutLogIn = @"SVEContinueWithoutLogIn";

static const NSUInteger SVEAuthorizationButtonOxOffsett = 50;
static const NSUInteger SVEAuthorizationButtonOyOffsett = 250;
static const NSUInteger SVEAuthorizationButtonCornerRadius = 45;
static const NSUInteger SVEAuthorizationButtonHeight = 75;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonOxOffsett = 50;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonOyOffsett = 150;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonCornerRadius = 45;
static const NSUInteger SVEcontinueWithoutAuthorizationButtonHeight = 75;


@interface SVEVkAuthorizationController () 

@property (nonatomic, strong) SVEVkAuthorizationService *authorizationService;
@property (nonatomic, strong) UIButton *authorizationButton;
@property (nonatomic, strong) UIButton *continueWithoutAuthorizationButton;

@end

@implementation SVEVkAuthorizationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authorizationService = [[SVEVkAuthorizationService alloc] init];
    self.authorizationService.SVEVkAuthorizationController = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupButtons];     
}

- (void)setupButtons
{
    self.authorizationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.authorizationButton.frame = CGRectMake(SVEAuthorizationButtonOxOffsett,
                                                CGRectGetHeight(self.view.frame) - SVEAuthorizationButtonOyOffsett,
                                                CGRectGetWidth(self.view.frame) - SVEAuthorizationButtonOxOffsett * 2,
                                                SVEAuthorizationButtonHeight);
    self.authorizationButton.layer.cornerRadius = SVEAuthorizationButtonCornerRadius;
    [self.authorizationButton setTitle:@"Log in" forState:UIControlStateNormal];
    self.authorizationButton.backgroundColor = [UIColor colorWithRed:70.0f/255.f
                                                               green:130.f/255.f
                                                                blue:180.f/255.f
                                                               alpha:1.f];
    [self.authorizationButton addTarget:self action:@selector(authorizeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.continueWithoutAuthorizationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.continueWithoutAuthorizationButton.frame = CGRectMake(SVEcontinueWithoutAuthorizationButtonOxOffsett,
                                                               CGRectGetHeight(self.view.frame)
                                                               - SVEcontinueWithoutAuthorizationButtonOyOffsett,
                                                               CGRectGetWidth(self.view.frame)
                                                               - SVEcontinueWithoutAuthorizationButtonOxOffsett * 2,
                                                               SVEcontinueWithoutAuthorizationButtonHeight);
    self.continueWithoutAuthorizationButton.layer.cornerRadius = SVEcontinueWithoutAuthorizationButtonCornerRadius;
    [self.continueWithoutAuthorizationButton setTitle:@"Continue without authorization" forState:UIControlStateNormal];
    self.continueWithoutAuthorizationButton.backgroundColor = [UIColor colorWithRed:178.f/255.f
                                                                              green:223.f/255.f
                                                                               blue:255.f/255.f
                                                                              alpha:1.f];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:SVEContinueWithoutLogIn object:nil];
}

@end
