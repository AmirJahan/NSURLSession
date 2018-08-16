#import "ViewController.h"
#import "ShowAlert.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self nba];
}





-(void)tempMethod
{
    // URL
    // REQUEST
    // SESSIONS
    // DATA Task
    // !no error => Data
    // Data  -> Serialized
    
    
    NSMutableURLRequest *tempUrlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:@"some url"]];
    
    NSURLSession *tempUrlSession = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    NSURLSessionDataTask *myTempDataTask = [tempUrlSession dataTaskWithRequest:tempUrlRequest
                         completionHandler:^(NSData * _Nullable data,
                                             NSURLResponse * _Nullable response,
                                             NSError * _Nullable error)  { }];
    [myTempDataTask resume];
}

-(void)nba
{
    // Setting up the url
    NSURL *url = [NSURL URLWithString:@"https://data.nba.net/prod/v2/20170218/scoreboard.json"];
    
    // setting the URL request using the url and the http method
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET"; // this is the default one any way
    // CRUD -> GET, POST, PUT, DELETE
    
    // A url session so we can make a request
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];
    

    // Data task, and the download task
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest
               completionHandler:^(NSData * _Nullable data,
                                   NSURLResponse * _Nullable response,
                                   NSError * _Nullable error)
  {
      // Here we access HTTP data , Status codes, and JSON
      // If we don't get a 200 status code, error will not be nil
      if (error)
      {
          NSLog(@"Error getting data");
      }
      else
      {
          NSError *jsonError = nil;
          NSDictionary *readStuffDict = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0
                                                                          error:&jsonError];
          
          NSLog(@"data that is converted into Dict is: %@", readStuffDict);
          
          if (jsonError)
          {

              NSLog(@"jsonError: %@", jsonError.localizedDescription);
          }
          else
          {
              NSLog(@"They are: %lu items in this database", (unsigned long)readStuffDict.count);
              
              // let's fetch the games Array
              NSArray* gamesArr = readStuffDict.allValues[1];

              // We now have our data as Objective-C data
              for (NSDictionary *game in gamesArr)
              {
                  NSDictionary *homeTeamDict = [game objectForKey:@"hTeam"];
                  
                  if ( [[homeTeamDict objectForKey: @"triCode"] isEqualToString: @"STP"])
                  {
                      // do somehrting
                  }
                  
                  NSString* homeTri = [homeTeamDict objectForKey:@"triCode"];
                  NSLog(@"Home Team is: %@", homeTri);

                  
                  NSDictionary *visitingTeamDict = [game objectForKey:@"vTeam"];
                  NSString* visitingTri = [visitingTeamDict objectForKey:@"triCode"];
                  NSLog(@"Visiting Team is: %@", visitingTri);
              }
              
              // update somethign in the interface based on the data
              // you will CRASH
              
              
              // dont update the cat picture here
              
              // Tell the main queue, to do somthing with the data// updates the interfac
              dispatch_async(dispatch_get_main_queue(), ^{
                  
                  [ShowAlert showAlertWith:@"Got it"
                                    within:self];
                  

                  
              });
          }
      }
  }];
    
    [dataTask resume]; // Start my request
}
@end
