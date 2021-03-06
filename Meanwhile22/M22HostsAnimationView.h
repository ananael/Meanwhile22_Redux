//
// M22HostsAnimationView.h
// Generated by Core Animator version 1.3.2 on 12/9/16.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

@import UIKit;

IB_DESIGNABLE
@interface M22HostsAnimationView : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;

// M22HostsAnimation
- (void)addM22HostsAnimation;
- (void)addM22HostsAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addM22HostsAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addM22HostsAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addM22HostsAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeM22HostsAnimation;

- (void)removeAllAnimations;

@end