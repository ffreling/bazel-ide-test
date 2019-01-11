#import "CustomView.h"
#include "core/foo/foo.hpp"

#import <UIKit/UIKit.h>

@implementation CustomView {
    Foo foo;
    CADisplayLink *link;
}

- initWithCoder:(null_unspecified NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat red = foo.r() / 255.;
        CGFloat green = foo.g() / 255.;
        CGFloat blue = foo.b() / 255.;
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        [self setBackgroundColor:color];

        link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat red = foo.r() / 255.;
    CGFloat green = foo.g() / 255.;
    CGFloat blue = foo.b() / 255.;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [self setBackgroundColor:color];

    [super drawRect:rect];
}

@end
