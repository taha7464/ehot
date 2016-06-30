//
//  AppDelegate.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/16/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@import GoogleSignIn;
@import Firebase;
@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

