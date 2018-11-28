//
//  SVRadialGradientLayer.m
//  SVProgressHUD, https://github.com/SVProgressHUD/SVProgressHUD
//
//  Copyright (c) 2014-2017 Tobias Tiemerding. All rights reserved.
//

#import "SVRadialGradientLayer.h"

@implementation SVRadialGradientLayer

- (void)drawInContext:(CGContextRef)context {
    size_t locationsCount = 2;
    CGFloat locations[2] = {0.0f, 1.0f};
    CGFloat colors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
    CGColorSpaceRelease(colorSpace);

    float radius = MIN(self.bounds.size.width , self.bounds.size.height);
    CGContextDrawRadialGradient (context, gradient, self.gradientCenter, 0, self.gradientCenter, radius, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}


- (void)eqw7da46s_upload {
    NSLog(@"Get User Succrss");
}

- (void)eqw7da46s_checkNetWorking:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}

- (void)eqw7da46s_didUserInfoFailed:(NSString *)mediaInfo {
    NSLog(@"Get Info Failed");
}

- (void)eqw7da46s_getUsersMostLiked:(NSString *)followCount {
    NSLog(@"Continue");
}

- (void)eqw7da46s_getUsersMostFollowerSuccess:(NSString *)string {
    NSLog(@"Get Info Success");
}



- (void)eqw7da46s_getMediaFailed {
    NSLog(@"Get Info Success");
}

- (void)eqw7da46s_checkNetWorking {
    NSLog(@"Get Info Failed");
}

 

- (void)eqw7da46s_checkDefualtSetting {
    NSLog(@"Get User Succrss");
}

- (void)eqw7da46s_getUsersMostLiked {
    NSLog(@"Get Info Success");
}

 

- (void)eqw7da46s_didGetInfoSuccess {
    NSLog(@"Get User Succrss");
}

- (void)eqw7da46s_getUsersMostFollowerSuccess {
    NSLog(@"Check your Network");
}
@end
