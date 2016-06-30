//
//  SearchViewController.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/16/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Yelp.h"
#import "SearchTableViewCell.h"
@import Firebase;

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) NSArray<NSDictionary *> *buisnesses;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSString *currentCity;
@property (strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)search:(id)sender;
@end

