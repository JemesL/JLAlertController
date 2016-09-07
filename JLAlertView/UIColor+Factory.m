//
//  UIColor+Factory.m
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "UIColor+Factory.h"

@implementation UIColor (Factory)


+ (UIColor *)convertHexToRGB:(NSString *)hexString alpha:(CGFloat)alpha
{
    NSString *str;
    if ( [hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"] ) {
        
        str=[[NSString alloc] initWithFormat:@"%@",hexString];
        
    } else {
        
        str=[[NSString alloc] initWithFormat:@"0x%@",hexString];
        
    }
    
    long long rgb;
    sscanf([str cStringUsingEncoding:NSUTF8StringEncoding], "%lli", &rgb);
    
#if ! __has_feature(objc_arc)
    [str release];
#endif
    
    NSInteger red = rgb / ( 256 * 256) % 256;
    NSInteger green = rgb / 256 % 256;
    NSInteger blue = rgb % 256;
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    
    return color;
}

+ (UIColor *)convertHexToRGB:(NSString *)hexString
{
    return [self convertHexToRGB:hexString alpha:1.0];
}

+ (UIColor *)colorAlertText
{
    return [UIColor convertHexToRGB:@"0xA7A7A7"];
}

+ (UIColor *)colorAlertBG
{
    return [UIColor convertHexToRGB:@"0xFFFFFF"];
}
@end
