
#import "LoginVC.h"
#import "ProfileVC.h"
#import "SignUpVC.h"

@interface LoginVC ()

@end

@import FirebaseCore;
@import FirebaseFirestore;
@import FirebaseAuth;

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)onClickButtonLogin:(id)sender {
    
    if ([self.txtEmail.text  isEqual: @""]){
        
        [self AddAlert : @"Please Enter Email"];
    }
    
    else if ([self.txtPassword.text  isEqual: @""]){
        
        [self AddAlert : @"Please Enter Password"];
        
    }   else{
        
        [[FIRAuth auth] signInWithEmail:self.txtEmail.text
                               password:self.txtPassword.text
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
          
             if (!error)  {
                
                 printf("Login");
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 //Now write your next view controller and write your storyboard id.
                 ProfileVC *profilevc = (ProfileVC *)[storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
                 profilevc.email = self.txtEmail.text;
                 [self.navigationController pushViewController:profilevc animated:YES];
                 
             }else{
                 
                 [self AddAlert : @"Please Enter Valid Credential"];
             }
           
            
        }];

    }
    
    
}


- (IBAction)onClickButtonSignUp:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //Now write your next view controller and write your storyboard id.
    SignUpVC *signupvc = (SignUpVC *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    [self.navigationController pushViewController:signupvc animated:YES];
    
}

- (void)AddAlert:(NSString *)message{
     UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message: message
                                 preferredStyle:UIAlertControllerStyleAlert];

    //Add Buttons
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];

    //Add your buttons to alert controller

    [alert addAction:okButton];


    [self presentViewController:alert animated:YES completion:nil];
}


@end
