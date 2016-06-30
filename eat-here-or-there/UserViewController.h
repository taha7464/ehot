//
//  UserViewController.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/30/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileTableViewController.h"
@import Firebase;
@interface UserViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) ProfileTableViewController *profileTableViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *historyData;
@property (weak, nonatomic) FIRDatabaseReference *ref;


@end
