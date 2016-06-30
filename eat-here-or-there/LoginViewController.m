//
//  LoginViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/23/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    _emailTF.delegate = self;
    [self setup];
}

- (void) setup {
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
    _fbButton.delegate = self;
    
    self.twitterButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession* session,
                                                 NSError* error) {
        if (session) {
            FIRAuthCredential *credential =
            [FIRTwitterAuthProvider credentialWithToken:session.authToken
                                                 secret:session.authTokenSecret];
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRUser *user, NSError *error) {
                                          [self didLogIn:error];
                                      }];
        } else {
            // ...
        }
    }];
}

#pragma mark login delegates

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (error == nil) {
        // ...
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      [self didLogIn:error];
                                  }];
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credential =
        [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                         accessToken:authentication.accessToken];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                     [self didLogIn:error];
                                  }];
    } else {
        
    }
}

#pragma mark UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _emailTF.errorMessage = @"";
}

#pragma mark login helpers
- (IBAction)createUser:(id)sender {
    [self performSegueWithIdentifier:@"createUser" sender:self];
}

- (IBAction)signIn:(id)sender {
    [[FIRAuth auth] signInWithEmail:_emailTF.text
                           password:_passwordTF.text
                         completion:^(FIRUser *user, NSError *error) {
                             [self didLogIn:error];
                         }];
}

-(void) didLogIn :(NSError *) error{
    if(error == nil)
        [self dismissViewControllerAnimated:YES completion:nil];
    else {
        _emailTF.errorMessage = @"Invalid Login";
    }
}
@end
