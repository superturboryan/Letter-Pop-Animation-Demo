//
//  AnimatedPopStackView.h
//  Letter-Pop-Animation-Demo
//
//  Created by Ryan David Forsyth on 2020-09-02.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimatedPopStackView : UIStackView

- (void)addLabelsForString:(NSString *)string animated:(BOOL)animated completion:(void(^)(void))completion;

- (void)clear;

@end

NS_ASSUME_NONNULL_END
