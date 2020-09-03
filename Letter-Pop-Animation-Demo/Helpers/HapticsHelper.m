//
//  HapticsHelper.m
//  PushCha
//
//  Created by Ryan Forsyth on 2019-12-16.
//  Copyright © 2019 Paul Boucher. All rights reserved.
//

#import "HapticsHelper.h"

@implementation HapticsHelper

+(void)notificationWithType:(UINotificationFeedbackType)type{
    UINotificationFeedbackGenerator *generator = [[UINotificationFeedbackGenerator alloc]init];
    [generator notificationOccurred:type];
    generator = nil;
}

+(void)selection {
    UISelectionFeedbackGenerator *generator = [[UISelectionFeedbackGenerator alloc]init];
    [generator selectionChanged];
    generator = nil;
}

+(void)impactWithStyle:(UIImpactFeedbackStyle)style {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc]initWithStyle:style];
    [generator impactOccurred];
    generator = nil;
}

@end
