//
//  LoginViewController.m
//  Instagram
//
//  Created by Dominique on 8/18/14.
//  Copyright (c) 2014 mobile makers. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@property NSMutableArray *users; 
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)onSignUpButtonPressed:(id)sender {

    UIAlertView *signUpAlertView = [[UIAlertView alloc]initWithTitle:@"Sign Up!" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Me Up!", nil];


    signUpAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField *newUsername = [signUpAlertView textFieldAtIndex:0];
    newUsername.placeholder = @"Username";
    newUsername.keyboardType = UIKeyboardTypeDefault;

    [signUpAlertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    /*
     if the user already exists
     */

    if (buttonIndex != alertView.cancelButtonIndex) {
        PFObject *user = [PFObject objectWithClassName:@"User"];
        user[@"username"] = [alertView textFieldAtIndex:0].text;
        user[@"password"] = [alertView textFieldAtIndex:1].text;

        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"%@", [error userInfo]);
            }else{
                [self refreshDisplay];
            }
        }];
    }
}

- (void) refreshDisplay
{
    PFQuery *query = [PFQuery queryWithClassName:@"User"]; //creating the query and only querying the person object

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //NSArray *objects is going to return all the User objects
        if (error) {
            NSLog(@"%@", [error userInfo]);
        }else{
            self.users = [objects mutableCopy]; //populating the array
            NSLog(@"%@", self.users);
        }
    }];
}



@end
