

#import <UIKit/UIKit.h>
@import DownPicker;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblBio;
@property (weak, nonatomic) IBOutlet UIDownPicker *txtCity;
@property (weak, nonatomic) IBOutlet UITableView *tblTime;
@property (nonatomic) DownPicker *picker;

@property (strong, nonatomic) NSMutableArray *arrTime;
@property (strong, nonatomic) NSMutableArray *arrTC;
@property (strong, nonatomic)NSDictionary *dictHour;

@property (strong, nonatomic)NSString *email;

@end

NS_ASSUME_NONNULL_END
