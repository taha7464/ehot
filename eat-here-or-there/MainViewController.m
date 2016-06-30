//
//  MainViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/30/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    // Instance creation.
    ESTabBarController *tabBarController = [[ESTabBarController alloc] initWithTabIconNames:@[@"first",
                                                                                              @"first",
                                                                                              @"first"]];
    
    // Add child view controller.
    
    [self addChildViewController:tabBarController];
    
    [self.view addSubview:tabBarController.view];
    tabBarController.view.frame = self.view.bounds;
    
    [tabBarController didMoveToParentViewController:self];
    
    // View controllers.
    
    [tabBarController setViewController:[self viewControllerAtIndex:0]
                                atIndex:0];
    
    [tabBarController setViewController:[self viewControllerAtIndex:1]
                                atIndex:1];
    
    [tabBarController setViewController:[self viewControllerAtIndex:2]
                                atIndex:2];
    
    
    // Colors.
    
    tabBarController.selectedColor = [UIColor redColor];
    tabBarController.buttonsBackgroundColor = [UIColor clearColor];
    
    // Highlighted buttons.
    
    [tabBarController highlightButtonAtIndex:1];
    
    // Actions.
    
    __weak typeof (self) weakSelf = self;
    
    [tabBarController setAction:^{

    } atIndex:2];
    
    [tabBarController setAction:^{
        
    } atIndex:4];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Create a new view controller and pass suitable data.
    switch (index) {
        case 0:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
            break;
        case 1:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"FindViewController"];
            break;
        case 2:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
            break;
            
        default:
            return nil;
    }
}


@end
