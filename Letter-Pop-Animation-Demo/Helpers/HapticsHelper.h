//
//  HapticsHelper.h
//  PushCha
//
//  Created by Ryan Forsyth on 2019-12-16.
//  Copyright © 2019 Paul Boucher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HapticsHelper : NSObject

+(void)notificationWithType:(UINotificationFeedbackType)type;
+(void)selection;
+(void)impactWithStyle:(UIImpactFeedbackStyle)style;

@end

NS_ASSUME_NONNULL_END
