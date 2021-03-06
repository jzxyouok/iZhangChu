//
//  ZCMacro.h
//  掌厨
//
//  Created by Shengping on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#ifndef ZCMacro_h
#define ZCMacro_h

#ifdef DEBUG //  处于开发阶段
#define ZCLog(...) NSLog(__VA_ARGS__)
#else //处于发布阶段
#define ZCLog(...)
#endif

// --------------------- 颜色专区 ----------------------
// RGB颜色
#define ZCColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
#define ZCRandomColor ZCColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)

// 项目主色
#define ZCGlobalColor [UIColor orangeColor]

#define ZCBackgroundColor ZCColorRGBA(248, 248, 248, 1)

// -----------------------------------------------------


#define greaterThaniOS(n) ([[UIDevice currentDevice].systemVersion doubleValue] >= n)

#import "ZCHeaderFile.h"
#import "ZCConst.h"



#endif /* ZCMacro_h */
