#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self nba];
}

-(void)nba
{
    // Setting up the url
//    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/amirjahan/repos"];
    NSURL *url = [NSURL URLWithString:@"https://data.nba.net/prod/v2/20171022/scoreboard.json"];

    // seeting the URL request using the url and the http method
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET"; // this is the default one any way
    
    
    // A url session so we can make a request
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];
    
    
    // Data task, and the download task
    // Create a task to make the request
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
          NSDictionary *readStuffDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
          
          if (jsonError)
          {
              NSLog(@"jsonError: %@", jsonError.localizedDescription);
          }
          else
          {
              NSLog(@"They are: %lu", (unsigned long)readStuffDict.count);
//              NSLog(@"They are: %@", readStuffDict.allValues[1]);

              
              NSArray* gamesArr = readStuffDict.allValues[1];
              
              
              
              // We now have our data as Objective-C data
              for (NSDictionary *game in gamesArr)
              {
                  NSDictionary *homeTeamDict = [game objectForKey:@"hTeam"];
                  NSLog(@"Home Team is: %@", [homeTeamDict objectForKey:@"triCode"]);
                  
                  NSDictionary *visitingTeamDict = [game objectForKey:@"hTeam"];
                  NSLog(@"Visiting Team is: %@", [visitingTeamDict objectForKey:@"triCode"]);
              }
              
              
                  // Tell the main queue, to do somthing
                  dispatch_async(dispatch_get_main_queue(), ^{
                  
              });
          }
      }
      
  }];
    
    [dataTask resume]; // Like saying start my request
    
    NSLog(@"view did load");
    
    
    
}

@end
