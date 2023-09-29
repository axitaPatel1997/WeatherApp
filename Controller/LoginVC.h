
#import <UIKit/UIKit.h>
@import SkyFloatingLabelTextField;

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : UIViewController

@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtEmail;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *txtPassword;


@end

NS_ASSUME_NONNULL_END
