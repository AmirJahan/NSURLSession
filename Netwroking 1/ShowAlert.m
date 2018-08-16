#import "ShowAlert.h"
#import <UIKit/UIKit.h>

@implementation ShowAlert

// class methods

+(void)showAlertWith:(NSString *)messageStr within:(UIViewController *)thisController
{
    UIAlertController* myCtrl = [UIAlertController alertControllerWithTitle:@"We got somethign"
                                                                    message:messageStr
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                     }];
    
    [myCtrl addAction: okAction];
    
    [thisController presentViewController:myCtrl animated:true completion:nil];
}


@end
