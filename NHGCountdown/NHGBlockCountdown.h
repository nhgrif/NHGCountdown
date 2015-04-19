//
//  NHGBlockCountdown.h
//  NHGCountdown
//
//  Created by Nick Griffith on 4/19/15.
//  Copyright (c) 2015 nhg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NHGCountdownCompletion)(void);
typedef void (^NHGCountdownUpdate)(NSUInteger);

@interface NHGBlockCountdown : NSObject

+ (instancetype)countdown;

- (void)startCountdownWithInterval:(NSTimeInterval)interval ticks:(NSUInteger)ticks update:(NHGCountdownUpdate)update completion:(NHGCountdownCompletion)completion;
- (void)stopCountdown;
@property (readonly) NSUInteger ticksRemaining;
@property (readonly) NSTimeInterval interval;

@end