//
//  CreateUserViewController.m
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/28/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import "CreateUserViewController.h"

@implementation CreateUserViewController



- (IBAction)submit:(id)sender {
    __block BOOL isValid = YES;
    if(_emailTF.text.length <= 0) {
        _emailTF.errorMessage = @"Required";
        isValid = NO;
    }
    if(_passwordTF.text.length <= 0) {
        _passwordTF.errorMessage = @"Required";
        isValid = NO;
    }
    if(_confirmTF.text.length <= 0) {
        _confirmTF.errorMessage = @"Required";
        isValid = NO;
    }
    if(isValid) {
        _emailTF.errorMessage = @"";
        _passwordTF.errorMessage = @"";
        _confirmTF.errorMessage = @"";
        isValid = isValid && YES;
    } else {
        return;
    }
    
    [_emailValidator validate];
    isValid = isValid && _emailValidator.isValid;
    if(isValid) {
        _emailTF.errorMessage = @"";
    } else {
        _emailTF.errorMessage = @"Not valid email";
        return;
    }
    [_passwordValidator validate];
    isValid = isValid && _passwordValidator.isValid;
    if(isValid) {
        _passwordTF.errorMessage = @"";
    } else {
        _passwordTF.errorMessage = @"Password must be atleast 8 characters";
        return;
    }
    if([_passwordTF.text isEqualToString:_confirmTF.text]) {
        _passwordTF.errorMessage = @"";
        _confirmTF.errorMessage = @"";
        isValid = isValid && YES;
    } else {
        _passwordTF.errorMessage = @"Passwords do not match";
        _confirmTF.errorMessage = @" ";
        isValid = NO;
        return;
    }
    
    [[FIRAuth auth]
     createUserWithEmail:_emailTF.text
     password:_passwordTF.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         if (error == nil) {
             UIAlertController * alert = [UIAlertController
                                          alertControllerWithTitle:@"Sucess"
                                          message:@"Created account!"
                                          preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                        }];
             
             
             [alert addAction:okButton];
             
             [self presentViewController:alert animated:YES completion:nil];
             [self performSegueWithIdentifier:@"createdUser" sender:self];
         } else {
             _emailTF.errorMessage = @"Unable to create account";
         }
         
     }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
