//
//  SearchViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/16/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated {
    [_locationManager startUpdatingLocation];
    [super viewWillAppear:animated];
}

#pragma mark Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_buisnesses count];     //row count
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"SearchItem";
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    NSDictionary *buisness = [_buisnesses objectAtIndex:indexPath.row];
    NSLog(@"Buisness Info \n: %@", buisness);
    NSURL *iconURL = [NSURL URLWithString:buisness[@"image_url"]];
    NSURL *ratingURL = [NSURL URLWithString:buisness[@"rating_img_url_small"]];
    cell.bName.text = buisness[@"name"];
    cell.iconImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:iconURL]];
    cell.ratingImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:ratingURL]];
    return cell;
}

- (IBAction)search:(id)sender {
    [self textFieldShouldReturn:_searchField];
}

#pragma mark UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [_locationManager startUpdatingLocation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (!_currentCity || !_currentLocation) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Location Error"
                                     message:@"Can't find your location"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Try Again"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    NSString *cll = [NSString stringWithFormat:@"%f,%f",_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude];
    NSDictionary *params = @{
                             @"term": textField.text,
                             @"location": _currentCity,
                             @"cll": cll,
                             @"limit": @10
                             };
    
    // Do any additional setup after loading the view, typically from a nib.
    Yelp *yelp = [[Yelp alloc] init];
    dispatch_group_t requestGroup = dispatch_group_create();
    
    dispatch_group_enter(requestGroup);
    [yelp queryBuisnesses:params completionHandler:^(NSArray *BusinessesJSON, NSError *error) {
        
        if (error) {
            NSLog(@"An error happened during the request: %@", error);
        } else if (BusinessesJSON) {
            //NSLog(@"Businesses info: \n %@", BusinessesJSON);
            _buisnesses = BusinessesJSON;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        } else {
            NSLog(@"No business was found");
        }
        dispatch_group_leave(requestGroup);
    }];
     //dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
    return NO;
}

#pragma mark CoreLocation Delegate
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager stopUpdatingLocation];
    _currentLocation = [locations lastObject];
    NSLog(@"lat%f - lon%f", _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude);
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:_currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       for (CLPlacemark *placemark in placemarks) {
                           _currentCity = [placemark locality];
                       }
                   }];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Location Error"
                                 message:@"Can't find your location"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Try Again"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
