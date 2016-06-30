//
//  UserViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/30/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import "UserViewController.h"

@implementation UserViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    /*
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        // Sign-out succeeded
    }
    */
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
                                                    FIRUser *_Nullable user) {
        if (user != nil) {
            // User is signed in.
            _ref = [[FIRDatabase database] reference];
            [[[_ref child:@"users" ] child:user.uid] setValue:@{@"email" : user.email}];
            
            [[_ref child:user.uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                // Get user value
                NSMutableDictionary *data = (NSMutableDictionary *) snapshot.value;
                _historyData = data[@"history"];
                if(_historyData != nil) {
                    [data removeObjectForKey:@"history"];
                    [_tableView reloadData];
                }
                [_profileTableViewController intialLoad:data];
                
            } withCancelBlock:^(NSError * _Nonnull error) {
                NSLog(@"%@", error.localizedDescription);
            }];
        } else {
            [self performSegueWithIdentifier:@"login" sender:self];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_historyData count];     //row count
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"HistoryItem";
    UITableViewCell *cell;
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"profile"]) {
         _profileTableViewController = (ProfileTableViewController *) [segue destinationViewController];
    }
        
}
-(IBAction)returnedFromSegue:(UIStoryboardSegue *)segue {
    NSLog(@"Returned from segue");
}

@end
