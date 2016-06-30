//
//  UserViewController.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/23/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>

@import SkyFloatingLabelTextField;
@import Firebase;
@import TwitterKit;
@import GoogleSignIn;

@interface UserViewController : UIViewController <FBSDKLoginButtonDelegate, GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *usernameTF;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *passwordTF;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbButton;
@property (weak, nonatomic) IBOutlet TWTRLogInButton *twitterButton;
@property (weak, nonatomic) IBOutlet GIDSignInButton *googleButton;

- (IBAction)createUser:(id)sender;
- (IBAction)signIn:(id)sender;

@end
