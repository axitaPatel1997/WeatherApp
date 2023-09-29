//
//  DetailViewController.m
//  Prectical_28Sep
//
//  Created by Elluminati on 29/09/23.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.dictData);
    self.lblwindmph.text = [ @"Wind MPH : " stringByAppendingFormat:@"%@" , self.dictData[@"wind_mph"]];
    self.lblwindKph.text = [ @"Wind KPH : " stringByAppendingFormat:@"%@", self.dictData[@"wind_kph"]];
    self.lblchanceOfRain.text = [ @"Chance Of Rain : " stringByAppendingFormat:@"%@" , self.dictData[@"chance_of_rain"]];
    self.lblchanceOfSnow.text = [ @"Chance Of Snow : " stringByAppendingFormat:@"%@" , self.dictData[@"chance_of_snow"]];
}



@end
