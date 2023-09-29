
#import "ProfileVC.h"
#import "DetailViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
@import FirebaseFirestore;


@interface ProfileVC ()

@property (nonatomic, readwrite) FIRFirestore *db;
@property FIRDatabaseReference *ref;

@end

@import FirebaseCore;
@import FirebaseFirestore;
@import FirebaseAuth;

@implementation ProfileVC

@synthesize arrTime;
@synthesize arrTC;
@synthesize dictHour;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.db = [FIRFirestore  firestore];
    [self.imgProfile.layer setCornerRadius:self.imgProfile.frame.size.height/2.0];
    [self.imgProfile setClipsToBounds:TRUE];
    
    NSArray *el = @[@"London", @"Andalusia", @"Anniston", @"Athens", @"Auburn" ,@"Bessemer"];
//    self.picker = [[DownPicker alloc] initWithTextField:self.txtCity withData:el];
  //  (void)[self.txtCity initWithData:el];
    
    self.picker = [[DownPicker alloc] initWithTextField:self.txtCity withData:el];
    
    //arrTime = [[NSMutableArray alloc]init]
  //  [self apiCall:@"https://api.weatherapi.com/v1/current.json?key=7555a23e901a4c46bf3192720232809&q=Andalusia&aqi=no"];
    
    
    [self.picker addTarget:self
        action:@selector(dp_Selected:)
        forControlEvents:UIControlEventValueChanged];
    
    [self getData];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
}

-(void)getData{
    
    FIRDocumentReference *docRef =
        [[self.db collectionWithPath:@"Users"] documentWithPath: self.email];
    [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
      if (snapshot.exists) {
        // Document data may be nil if the document exists but has no keys or values.
          self.lblName.text = snapshot.data[@"userName"];
          self.lblBio.text = snapshot.data[@"shortBio"];
      } else {
        NSLog(@"Document does not exist");
      }
        
    }];
}

-(void)dp_Selected:(id)dp {
    
    NSString* selectedValue = [self.txtCity text];
    NSLog(@"%@", selectedValue);
    
    //NSString * apiUrl = [@"https://api.weatherapi.com/v1/current.json?key=7555a23e901a4c46bf3192720232809&q=" stringByAppendingFormat:@"%@%@", selectedValue, @"&aqi=no"];
    NSString * apiUrl = [@"https://api.weatherapi.com/v1/history.json?key=7555a23e901a4c46bf3192720232809&q=" stringByAppendingFormat:@"%@%@%@", selectedValue, @"&dt=", @"2023-09-29"];
    https://api.weatherapi.com/v1/history.json?key=7555a23e901a4c46bf3192720232809&q=Andalusia&dt=2023-09-29
    
    [self apiCall: apiUrl];
}

- (void)apiCall:(NSString *)url
{
   // making a GET request to /init
   //NSString *targetUrl = [NSString stringWithFormat:@"%@/init", url];.
   NSString *targetUrl = [NSString stringWithFormat:@"%@", url];
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   [request setHTTPMethod:@"GET"];
   [request setURL:[NSURL URLWithString:targetUrl]];

   [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
     ^(NSData * _Nullable data,
       NSURLResponse * _Nullable response,
       NSError * _Nullable error) {

    //   NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

       NSString *strISOLatin = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
       NSData *dataUTF8 = [strISOLatin dataUsingEncoding:NSUTF8StringEncoding];

       id dict = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:0 error:&error];
       if (dict != nil) {
           
           NSDictionary *forecast = dict[@"forecast"];
           
           NSDictionary *arrForecastday = forecast[@"forecastday"][0];
           
           NSDictionary *arrHour = arrForecastday[@"hour"];
           
           self.dictHour = arrHour;
           self.arrTime = [NSArray arrayWithObjects:self.dictHour,nil];

//               for (id key in dictHour)
//               {
//                   NSLog(key);
//               }
           dispatch_async(dispatch_get_main_queue(), ^{
               
               [self.tblTime reloadData];
           });
       } else {
           NSLog(@"Error: %@", error);
       }
       
   }] resume];
}

- (IBAction)onClickLogoutButton:(id)sender {
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }else{
        NSLog(@"Successfully Signout");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


//MARK: - Tableview Delegate && Data Source Method

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dictHour.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSLog(@"Error: %@", dictHour);
    
    //    cell.textLabel.text=[arrTime objectAtIndex:indexPath.row];
    //    cell.detailTextLable.text=[arrTC objectAtIndex:indexPath.row];
    
    NSDictionary *data = arrTime[0][indexPath.row];
    
    cell.textLabel.text = data[@"time"];
    cell.detailTextLabel.text = data[@"temp_f"];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [@"Time:" stringByAppendingFormat:@" %@ %@ %@ ", data[@"time"], @"T_C:", data[@"temp_f"]];
    //NSLog(cell.textLabel.text);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //Now write your next view controller and write your storyboard id.
    DetailViewController *detailvc = (DetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailvc.dictData = arrTime[0][indexPath.row];
    [self.navigationController pushViewController:detailvc animated:YES];
    
}


@end
