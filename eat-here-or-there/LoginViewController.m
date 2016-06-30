//
//  UserViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/23/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import "UserViewController.h"

@implementation UserViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
                                                    FIRUser *_Nullable user) {
        if (user != nil) {
            // User is signed in.
        } else {
            // No user is signed in.
        }
    }];
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
                                          // ...
                                      }];
        } else {
            // ...
        }
    }];
}

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
                                      // ...
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
                                      // ...
                                  }];
    } else {
        
    }
}
- (IBAction)createUser:(id)sender {
}

- (IBAction)signIn:(id)sender {
}
@end
