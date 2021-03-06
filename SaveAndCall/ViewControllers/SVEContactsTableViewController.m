//
//  SVEContactsTableViewController.m
//  SaveAndCall
//
//  Created by Влад Снигирев on 29/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

#import "SVEContactsTableViewController.h"
#import "SVEContactsService.h"
#import "SVEContactsTableCell.h"
#import "SVEContactsProtocol.h"
#import "SVEContactRepresentation.h"
#import "SVEContactsModel.h"
#import "AppDelegate.h"
#import "SVESynchronizationService.h"


static NSString *const SVELogoutFromVk = @"SVELogoutFromVk";
static NSString *reuseIdentifier = @"SVEContactTableViewCell";
static CGFloat SVERefreshContactsTime = 0.9f;


@interface SVEContactsTableViewController () <SVEContactsProtocol>


@property (nonatomic, strong) UIBarButtonItem *sychronizeButton;
@property (nonatomic, strong) SVEContactsService *contactService;
@property (nonatomic, strong) SVEContactsModel *model;
@property (nonatomic, strong) SVESynchronizationService *synchronizedService;
@property (nonatomic, strong) NSArray *synchronizedArray;


@end

@implementation SVEContactsTableViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBarButtonItems];
    [self setupTableView];
    [self setupContactService];
    AppDelegate *a = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.model = a.contactsModel;
    [self.contactService getContacts];
}


#pragma mark - Private

- (void)setupTableView
{
    [self.tableView registerClass:[SVEContactsTableCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupBarButtonItems
{
    self.sychronizeButton = [[UIBarButtonItem alloc] initWithTitle:@"Sychronize" style:UIBarButtonItemStylePlain target:self action:@selector(synchronize)];
    [self.navigationItem setRightBarButtonItems:@[self.sychronizeButton]];
}

- (void)setupContactService
{
    self.contactService = [[SVEContactsService alloc] init];
    self.contactService.delegate = self;
}


#pragma mark - Buttons' Actions

- (void)synchronize
{
    self.synchronizedService = [[SVESynchronizationService alloc] init];
    [self.synchronizedService synchronizeContactsWithfriends];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
    dispatch_time_t refreshTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)SVERefreshContactsTime * NSEC_PER_SEC);
    dispatch_after(refreshTime, dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
        {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.contacts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVEContactsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[SVEContactsTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    SVEContactRepresentation *contact = self.model.contacts[indexPath.row];
    cell = [cell configureCell:cell withContact:contact];
    [cell updateConstraints];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Your Contacts"];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.f;
}


#pragma mark - SVEContactsProtocol

/*Приходит массив контактов - SVEParseHelper разбирает его и присваевает contactsArray равным массиву моделей*/
- (void)gotContactsWithArray:(NSArray *)contactsArray
{
    [self.model configureModelWithContactsArray:contactsArray];
}


@end
