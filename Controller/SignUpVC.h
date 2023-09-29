

#import <UIKit/UIKit.h>
@import SkyFloatingLabelTextField;

NS_ASSUME_NONNULL_BEGIN

@interface SignUpVC : UIViewController <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtEmail;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtPassword;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtUserName;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtShortBio;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;



@end

NS_ASSUME_NONNULL_END
