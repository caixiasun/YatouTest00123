//
//  DLog.h
//  YatouTest00123
//
//  Created by caixiasun on 2016/12/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

#ifndef DLog_h
#define DLog_h


#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__);
#else
#define DLog(...) /**/
#endif

#endif
