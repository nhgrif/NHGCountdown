//
//  NHGCountdown.h
//  NHGCountdown
//
//  Created by Nick Griffith on 4/19/15.
//  Copyright (c) 2015 nhg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  NHGCountdown;

@protocol NHGCountdownDelegate <NSObject>

@required - (void)countdownComplete:(NHGCountdown *)countdown;
@optional - (void)countdownUpdate:(NHGCountdown *)countdown;

@end

@interface NHGCountdown : NSObject

- (instancetype)initWithDelegate:(id<NHGCountdownDelegate>)delegate;
+ (instancetype)countdownWithDelegate:(id<NHGCountdownDelegate>)delegate;

@property (weak) id<NHGCountdownDelegate> delegate;

- (void)startCountdownWithInterval:(NSTimeInterval)interval ticks:(NSUInteger)ticks;
- (void)stopCountdown;

@property (readonly) NSUInteger ticksRemaining;
@property (readonly) NSTimeInterval interval;

@end
