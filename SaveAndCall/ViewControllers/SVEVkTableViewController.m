//
//  SVEVkTableViewController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 29/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEVkTableViewController.h"
#import "SVEVkTableCell.h"
#import "SVENetworkServiceProtocol.h"
#import "SVENetworkService.h"
#import "SVEFriendRepresentation.h"
#import "AppDelegate.h"
#import "SVEVkModel.h"


static NSString *reuseIdentifier = @"VkTableCell";
static CGFloat SVERefreshTableTime = 1.f;


@interface SVEVkTableViewController () <SVENetworkServiceProtocol>


@property (nonatomic, strong) UIBarButtonItem *logoutButton;
@property (nonatomic, strong) SVENetworkService *networkService;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) SVETokenService *tokenService;
@property (nonatomic, strong) SVEVkModel *model;
@property (nonatomic, copy) NSArray *friends;


@end

@implementation SVEVkTableViewController

@dynamic refreshControl;


#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [self.tokenService isLogged];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtons];
    [self setupTableView];
    [self setupNetworkService];
    [self setupRefreshControl];
    [self.refreshControl beginRefreshing];
    AppDelegate *a = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    a.tokenService.delegate = self;
    self.model = a.vkModel;
    self.friends = self.model.vkFriends;
    self.tokenService = a.tokenService;
    [self.networkService getFriends];
}


#pragma mark - Private

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshFriends) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)setupTableView
{
    [self.tableView registerClass:[SVEVkTableCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupBarButtons
{
    self.logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    [self.navigationItem setLeftBarButtonItems:@[self.logoutButton]];
}

- (void)refreshFriends
{
    [self.tokenService isLogged];
    
    [self.networkService getFriends];
}

-(void) setupNetworkService
{
    self.networkService = [[SVENetworkService alloc] init];
    self.networkService.delegate = self;
}


#pragma mark - Buttons' Actions

- (void)logout
{
    [self.tokenService clearUserDefaults];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEVkTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[SVEVkTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    SVEFriendRepresentation *friend = self.friends[indexPath.row];
    cell = [cell configureCell:cell withFriend:friend];
    [cell updateConstraints];
    return cell;
}


#pragma mark - NetworkServiceProtocol

- (void)loadingIsDoneWithDataReceived:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.model configureModelWithData:data];
        dispatch_time_t refreshTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)SVERefreshTableTime * NSEC_PER_SEC);
        dispatch_after(refreshTime,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_group_t dispatchGroup = dispatch_group_create();
            for (SVEFriendRepresentation *friend in self.model.vkFriends)
            {
                dispatch_group_enter(dispatchGroup);
                if (!friend.photo_100_image)
                {
                    friend.photo_100_image = [self.networkService downloadImageByURL:friend.photo_100_Url];
                }
                dispatch_group_leave(dispatchGroup);
            }
            dispatch_group_wait(dispatchGroup, 0);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.friends = nil;
                [self.tableView reloadData];
                self.friends = self.model.vkFriends;
                [self.tableView performBatchUpdates:^{
                    for (NSUInteger i = 0; i < [self.model countOfVkFriends]; i++)
                    {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    [self.refreshControl endRefreshing];
                } completion:nil];
            });
        });
    });
}


@end
