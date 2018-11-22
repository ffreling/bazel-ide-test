#import "CustomView.h"

@implementation CustomView {
}

- initWithCoder:(null_unspecified NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
    }

    return self;
}

@end
