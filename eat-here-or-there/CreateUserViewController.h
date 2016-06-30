//
//  CreateUserViewController.h
//  eat-here-or-there
//
//  Created by Dhananjay Suresh on 6/28/16.
//  Copyright © 2016 Dhananjay Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import SkyFloatingLabelTextField;
@import APValidators;
@interface CreateUserViewController : UIViewController

@property (strong, nonatomic) IBOutlet APRequiredValidator *requiredValidator;
@property (strong, nonatomic) IBOutlet APRegexValidator *passwordValidator;
@property (strong, nonatomic) IBOutlet APEmailValidator *emailValidator;
@property (strong, nonatomic) IBOutlet APEqualStringValidator *confirmValidator;

@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *emailTF;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *passwordTF;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextFieldWithIcon *confirmTF;

- (IBAction)submit:(id)sender;


@end
