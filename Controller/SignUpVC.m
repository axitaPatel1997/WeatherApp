
#import "SignUpVC.h"
//#import <FirebaseStorage/FirebaseStorage.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
@import FirebaseFirestore;

@interface SignUpVC ()

@property NSString *uid;
@property (nonatomic, readwrite) FIRFirestore *db;
@property NSString *imageURL;

@end

@import FirebaseCore;
@import FirebaseFirestore;
@import FirebaseAuth;
//@import Fierbase;

@implementation SignUpVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.db = [FIRFirestore  firestore];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    [self.imgProfile.layer setCornerRadius:self.imgProfile.frame.size.height/2.0];
    [self.imgProfile setClipsToBounds:TRUE];

}


- (IBAction)onClickPicImage:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imagePicked = info[UIImagePickerControllerEditedImage];
    picker.delegate = self;
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSURL *url = info[@"UIImagePickerControllerImageURL"];
    self.imageURL = url.absoluteString;
    self.imgProfile.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
   [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onclickSignUp:(id)sender {
 
    if (self.imageURL == nil){
        
        [self AddAlert : @"Please Select Profile image"];
    }
    
    else if ([self.txtEmail.text  isEqual: @""]){
        
        [self AddAlert : @"Please Enter Email"];
        
    }else if ([self.txtPassword.text  isEqual: @""]){
        
        [self AddAlert : @"Please Enter Password"];
        
    }else if ([self.txtConfirmPassword.text  isEqual: @""]){
        
        [self AddAlert : @"Please Enter Confirm Password"];
        
    }else if (![self.txtConfirmPassword.text isEqual:self.txtPassword.text]){
        
        [self AddAlert : @"Please Check Password And Confirm Password"];
        
    }else{
        
        [[FIRAuth auth] createUserWithEmail:self.txtEmail.text
                                   password:self.txtPassword.text
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
            
            printf("Auth");

            if (!error) {
                
                [self addNewUser:self.uid email:self.txtEmail.text userName:self.txtUserName.text shortBio:_txtShortBio.text imageURL:self.imageURL];
            }else{
                
                [self AddAlert : error.localizedDescription];
            }
        }];
    }
    

    
}

- (void)addNewUser:(NSString *)userID email:(NSString *)email userName:(NSString *)userName shortBio:(NSString *)shortBio imageURL:(NSString *)imageURL
{
    [[[self.db collectionWithPath:@"Users"] documentWithPath:email] setData:@{
      @"email": email,
      @"userName": userName,
      @"shortBio": shortBio,
      @"imageURL": imageURL
    } completion:^(NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"Error writing document: %@", error);
      } else {
          [self.navigationController popToRootViewControllerAnimated:YES];
      }
    }];

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
