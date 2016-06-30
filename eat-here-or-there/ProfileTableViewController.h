//
//  HistoryTableViewController.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/30/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SkyFloatingLabelTextField;

@interface HistoryTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *nameTF;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *emailTF;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *locationTF;

-(void)intialLoad:(NSDictionary *) values;

@end
