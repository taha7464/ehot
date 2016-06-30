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
    __block BOOL isValid = false;
    [_requiredValidator validate];
    isValid = isValid && _requiredValidator.isValid;
    if(isValid) {
        _emailTF.errorMessage = @"";
        _passwordTF.errorMessage = @"";
        _confirmTF.errorMessage = @"";
    } else {
        if(_emailTF.text.length <= 0)
            _emailTF.errorMessage = @"Required";
        if(_passwordTF.text.length <= 0)
            _passwordTF.errorMessage = @"Required";
        if(_confirmTF.text.length <= 0)
            _confirmTF.errorMessage = @"Required";
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
        _passwordTF.errorMessage = @"Not valid password";
        return;
    }
    [_confirmValidator validate];
    isValid = isValid && _confirmValidator.isValid;
    if(isValid) {
        _passwordTF.errorMessage = @"";
        _confirmTF.errorMessage = @"";
    } else {
        _passwordTF.errorMessage = @"Passwords do not match";
        _confirmTF.errorMessage = @" ";
        return;
    }
    
    [[FIRAuth auth]
     createUserWithEmail:_emailTF.text
     password:_passwordTF.text
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         // ...
     }];
}
@end
