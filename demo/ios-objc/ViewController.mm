#import <UIKit/UIKit.h>
#import "sdk/ios/CustomView.h"
#import "ViewController.h"


@implementation ViewController {
    CustomView *customView;
}

- (void)loadView {
    customView = [[CustomView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = customView;
}

@end
