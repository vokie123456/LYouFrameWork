//
//  LYouMacro.h
//  LYouFrameWork
//
//  Created by grx on 2018/11/27.
//  Copyright © 2018年 grx. All rights reserved.
//

#ifndef LYouMacro_h
#define LYouMacro_h
/*! 屏幕宽高尺寸 */
#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height

#define IsPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
/** 屏幕旋转宽高 */
#define Main_Rotate_Width  (IsPortrait ? Main_Screen_Width : Main_Screen_Height)
#define Main_Rotate_Height  (IsPortrait ? Main_Screen_Height : Main_Screen_Width)

/*! 颜色 */
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorWithRGB(r,g,b) ColorWithRGBA(r,g,b,1)
#define ColorWithHexRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define ColorWithHexRGB(rgbValue) ColorWithHexRGBA(rgbValue,1.0)
/*! 全局黑字体颜色 */
#define UIColorBlackTheme ColorWithHexRGB(0x2d2d2d)
/* 平方-细体 */
#define LYFont_Semibold(font) [UIFont fontWithName:@"PingFangSC-Semibold"size:font]
#define LYFont_Medium(font) [UIFont fontWithName:@"PingFangSC-Medium"size:font]
#define LYFont_Regular(font) [UIFont fontWithName:@"PingFangSC-Regular"size:font]

/*! 其他 */
#define StandardUserDefaults [NSUserDefaults standardUserDefaults]
#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#endif /* LYouMacro_h */
