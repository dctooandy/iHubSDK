//
//  iHubSDK.h
//  iHubSDK
//
//  Created by 經昌ＩＯＴ on 2024/10/23.
//

#import <Foundation/Foundation.h>

//! Project version number for iHubSDK.
FOUNDATION_EXPORT double iHubSDKVersionNumber;

//! Project version string for iHubSDK.
FOUNDATION_EXPORT const unsigned char iHubSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <iHubSDK/PublicHeader.h>

// 嘗試這些不同的引入方式（選擇一個有效的）：
#if __has_include(<videoSDK/ConnectNode.h>)
    #import <videoSDK/ConnectNode.h>
#elif __has_include("videoSDK/ConnectNode.h")
    #import "videoSDK/ConnectNode.h"
#elif __has_include("ConnectNode.h")
    #import "ConnectNode.h"
#endif
