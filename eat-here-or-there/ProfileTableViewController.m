//
//  ProfileTableViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/30/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ProfileTableViewController.h"

@implementation ProfileTableViewController : UITableViewController

-(void)intialLoad:(NSDictionary *) values {
    _emailTF.text = values[@"email"];
    
}

@end
