//
//  DetailViewController.h
//  Prectical_28Sep
//
//  Created by Elluminati on 29/09/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblwindKph;
@property (weak, nonatomic) IBOutlet UILabel *lblwindmph;
@property (weak, nonatomic) IBOutlet UILabel *lblchanceOfSnow;
@property (weak, nonatomic) IBOutlet UILabel *lblchanceOfRain;

@property (strong, nonatomic)NSDictionary *dictData;

@end

NS_ASSUME_NONNULL_END
