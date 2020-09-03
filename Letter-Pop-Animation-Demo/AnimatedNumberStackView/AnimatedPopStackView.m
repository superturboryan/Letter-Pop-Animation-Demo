//
//  AnimatedPopStackView.m
//  Letter-Pop-Animation-Demo
//
//  Created by Ryan David Forsyth on 2020-09-02.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

#import "AnimatedPopStackView.h"
#import "NSString+Helper.h"
#import "HapticsHelper.h"

@interface AnimatedPopStackView()

@end

@implementation AnimatedPopStackView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    self.alignment = UIStackViewAlignmentCenter;
    self.distribution = UIStackViewDistributionFillProportionally;
    self.spacing = -17.0;
    self.clipsToBounds = NO;
}

- (void)addLabelsForString:(NSString *)string animated:(BOOL)animated {
    
    NSArray<NSString *> *individualChars = string.charArray;
    
    [individualChars enumerateObjectsUsingBlock:^(NSString * _Nonnull string, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *newCharLabel = [[UILabel alloc] init];
        newCharLabel.text = string;
        newCharLabel.font = [UIFont fontWithName:@"Bungee-Regular" size:130];
        newCharLabel.textColor = UIColor.whiteColor;
        newCharLabel.adjustsFontSizeToFitWidth = YES;
        newCharLabel.minimumScaleFactor = 0.5;
        [self addArrangedSubview:newCharLabel];
        
        //Shadow
        newCharLabel.layer.shadowColor = UIColor.systemPinkColor.CGColor;
        newCharLabel.layer.shadowOffset = CGSizeMake(0, 5);
        newCharLabel.layer.shadowOpacity = 1.0;
        newCharLabel.layer.shadowRadius = 0;
        
        //Animation
        CGAffineTransform rotate = CGAffineTransformMakeRotation([self rotationDegreesForIndex:idx withTotalCount:individualChars.count] * M_PI/180);
        CGAffineTransform raise = CGAffineTransformMakeTranslation(0, [self raiseForIndex:idx withTotalCount:individualChars.count]);
        CGAffineTransform shrink = CGAffineTransformMakeScale(0.001, 0.001);

        if (!animated) {
            newCharLabel.transform = CGAffineTransformConcat(rotate, raise);
        }
        else {
            newCharLabel.transform = shrink;
            newCharLabel.alpha = 0;
            [self softHaptic];
            [UIView animateWithDuration:0.35
                                  delay:(idx * 0.35)
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                [self performSelector:@selector(softHaptic) withObject:nil afterDelay:(idx * 0.35)];
                newCharLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 1), CGAffineTransformConcat(rotate, raise));
                newCharLabel.alpha = 1.0;
            } completion:^(BOOL finished) {
                BOOL isLastChar = idx == individualChars.count - 1;
                if (isLastChar) {
                    [self showEmojiPopup];
                }
            }];
        }
    }];
}

-(void)softHaptic {
    [HapticsHelper impactWithStyle:UIImpactFeedbackStyleSoft];
}

-(void)showEmojiPopup {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.font = [UIFont systemFontOfSize:80];
    label.text = @"😬";
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    
    label.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 40);
    label.transform = CGAffineTransformMakeScale(0.001, 0.001);
    label.alpha = 0.0;
    
    [self performSelector:@selector(softHaptic) withObject:nil afterDelay:0.1];
    [UIView animateWithDuration:0.45 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        label.transform = CGAffineTransformMakeScale(2, 2);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [HapticsHelper impactWithStyle:UIImpactFeedbackStyleHeavy];
        }];
    }];
    
}

-(double)rotationDegreesForIndex:(NSUInteger)index withTotalCount:(NSUInteger)count {
    double left = -10;
    double right = 10;
    NSUInteger half = count % 2 == 0 ? count / 2 : (count / 2) + 1;
    
    if (index == half - 1 && count % 2 != 0) {
        return 0;
    }
    
    return index < half ? left : right;
}

-(double)raiseForIndex:(NSUInteger)index withTotalCount:(NSUInteger)count {
    
    return count > 2 && index != 0 && index != count-1 ? -10 : 0;
}

- (void)clear  {
    [self.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview,
                                                                      NSUInteger idx,
                                                                      BOOL * _Nonnull stop) {
        [self removeArrangedSubview:subview];
        [subview removeFromSuperview];
    }];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        [subview removeFromSuperview];
    }];
}

@end



