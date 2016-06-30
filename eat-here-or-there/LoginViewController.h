//
//  LoginViewController.h
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

@interface LoginViewController : UIViewController <FBSDKLoginButtonDelegate, GIDSignInUIDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *emailTF;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *passwordTF;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbButton;
@property (weak, nonatomic) IBOutlet TWTRLogInButton *twitterButton;
@property (weak, nonatomic) IBOutlet GIDSignInButton *googleButton;

- (IBAction)createUser:(id)sender;
- (IBAction)signIn:(id)sender;

@end
